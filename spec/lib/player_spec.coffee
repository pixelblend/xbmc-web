describe 'Player', () ->
  beforeEach () ->
    @playlist = new PlaylistCollection
    spyOn(@playlist, 'bind')
    @player = new Player @playlist
  
  it "should be stopped when XBMC is not running", () ->
    expect(@player.get('state')).toEqual('stopped')
  
  it "should bind triggers to the playlist", () ->
    expect(@playlist.bind).toHaveBeenCalled
    expect(@playlist.bind.callCount).toBe(4)
    
    arguments = _.map @playlist.bind.argsForCall, (arg) -> arg[0]
    
    expect(arguments).toEqual(['action:prev', 'action:next', 'action:play-pause', 'action:stop'])
  
  describe "when XBMC is playing music", () ->
    beforeEach () ->
      spyOn($, "ajax").andCallFake (options) ->
        options.success(XBMCResponse.audio_player)
      @player.fetch()
    
    it "detects an active audio player", () ->
      expect(@player.get('media')).toBe('audio')

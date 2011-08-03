describe 'Player', () ->
  beforeEach () ->
    @player = new Player
  
  it "should be stopped when XBMC is not running", () ->
    expect(@player.get('state')).toEqual('stopped')
    
  describe "when XBMC is playing music", () ->
    beforeEach () ->
      spyOn($, "ajax").andCallFake (options) ->
        options.success(XBMCResponse.audioPlayer)

      spyOn(@player, 'bindPlaylist')
      @player.fetch()
  
    it "should bind triggers to the playlist", () ->
      expect(@player.bindPlaylist.callCount).toBe(1)
    
    it "detects an active audio player", () ->
      expect(@player.playlist.model).toBe(Audio)
      expect(@player.get('state')).toBe('audio')

    describe "when detecting a new playlist type", () ->
      beforeEach () ->
        $.ajax.andCallFake (options) ->
          options.success(XBMCResponse.videoPlayer)

      it "changes to relevant playlist", () ->
        @player.fetch()

        expect(@player.playlist.model).toBe(Video)        
        expect(@player.get('state')).toBe('video')
    
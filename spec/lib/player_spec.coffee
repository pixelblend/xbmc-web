describe 'Player', () ->
  beforeEach () ->
    @player = new Player
  
  it "should be stopped when XBMC is not running", () ->
    expect(@player.get('media')).toEqual('stopped')
    
  describe "when XBMC is playing music", () ->
    beforeEach () ->
      spyOn($, "ajax").andCallFake (options) ->
        options.success(XBMCResponse.audio_player)
      @player.fetch()
    
    it "detects an active audio player", () ->
      expect(@player.get('media')).toBe('audio')
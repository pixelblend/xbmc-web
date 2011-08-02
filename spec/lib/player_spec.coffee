describe 'Player', () ->
  beforeEach () ->
    @player = new Player
  
  it "should be stopped when XBMC is not running", () ->
    expect(@player.get('state')).toEqual('stopped')
    
  describe "when XBMC is playing music", () ->
    beforeEach () ->
      spyOn($, "ajax").andCallFake (options) ->
        options.success(XBMCResponse.audio_player)

      spyOn(@player, 'bind_playlist')
      @player.fetch()
  
    it "should bind triggers to the playlist", () ->
      expect(@player.bind_playlist.callCount).toBe(1)
    
    it "detects an active audio player", () ->
      expect(@player.playlist.media).toBe('Audio')
      expect(@player.get('state')).toBe('audio')

    describe "when detecting a new playlist type", () ->
      beforeEach () ->
        $.ajax.andCallFake (options) ->
          options.success(XBMCResponse.video_player)

      it "changes to relevant playlist", () ->
        @player.fetch()

        expect(@player.get('state')).toBe('video')
        expect(@player.playlist.media).toBe('Video')        
    
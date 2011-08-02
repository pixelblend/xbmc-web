describe "VideoPlaylist", () ->
  beforeEach () ->
    @playlist = new VideoPlaylist

  it "has a JSON method", () ->
    expect(@playlist.method()).toEqual('VideoPlaylist.GetItems')

  it "starts with a state of stopped", () ->
    expect(@playlist.state).toEqual('stopped')

  describe "Collection", () ->
    beforeEach () ->
      spyOn($, "ajax").andCallFake (options) ->
        options.success(XBMCResponse.videoPlaylist)

      @playlist.fetch()

    describe "playlist", () ->
      it "fetches playlist", () ->
        expect(@playlist.models.length).toEqual(2)

      it "knows the current item in the playlist", () ->
        expect(@playlist.current).toEqual(1)

      it "knows the playlist is playing", () ->
        expect(@playlist.state).toEqual('playing')

    describe "model", () ->
      it "creates a playlist of video tracks", () ->
        model = _(@playlist.models).first()
        expect(model.constructor).toEqual(Video)

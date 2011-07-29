describe "playlist", () ->
  beforeEach () ->
    @playlist = new AudioPlaylist
    
  it "should exist", () ->
    expect(@playlist).toBeDefined();
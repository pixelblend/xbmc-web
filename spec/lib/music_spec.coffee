describe "Music", () ->
  beforeEach () ->
    @music = new Music XBMCResponse.audio_playlist.result.items[0]
  
  it "has a title", () ->
    expect(@music.get('title')).toEqual("Baba O'Riley")
  
  it 'generates a thumbnail', () ->
    expect(@music.thumbnail()).toEqual('http://xbmc:xbmc@localhost:8080/vfs/special://masterprofile/Thumbnails/Music/b/bba74b1e.tbn')
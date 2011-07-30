describe "Music", () ->
  beforeEach () ->
    @music = new Music
      title: 'Prison Song'
      artist: 'System of a Down'
      album: 'Toxicity'
  
  it "has a title", () ->
    expect(@music.get('title')).toEqual('Prison Song')
  
  it 'generates a thumbnail', () ->
    expect(@music.thumbnail()).toEqual('Prison Song - System of a Down.jpg')
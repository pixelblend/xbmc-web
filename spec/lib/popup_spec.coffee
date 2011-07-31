describe 'Popup', () ->
  beforeEach () =>
    @popup = new Popup
      collection: new AudioPlaylist
  
  it "should exist", () =>
    expect(@popup).toBeDefined();
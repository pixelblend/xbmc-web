describe "Music", () ->
  describe "an empty object", () ->
    beforeEach () ->
      @music = new Music
    
    it "has default attributes", () ->
      expect(_.keys(@music.attributes)).toEqual ['title', 'artist', 'album', 'thumbnail']
      
  describe "a complete object", () ->
    beforeEach () ->
      @music = new Music XBMCResponse.audio_playlist.result.items[0]
  
    it "has a title", () ->
      expect(@music.get('title')).toEqual("Baba O'Riley")
  
    it "generates a thumbnail", () ->
      expect(@music.thumbnail()).toMatch('bba74b1e.tbn')
  
    it "produces a view-friendly object", () ->
      expect(_.keys(@music.to_view())).toEqual  ['title', 'artist', 'album', 'thumbnail', 'fanart', 'file', 'label']
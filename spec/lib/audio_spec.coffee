describe "Audio", () ->
  describe "an empty object", () ->
    beforeEach () ->
      @audio = new Audio
    
    it "has default attributes", () ->
      expect(_.keys(@audio.attributes)).toEqual ['title', 'artist', 'album', 'thumbnail']
      
  describe "a complete object", () ->
    beforeEach () ->
      @audio = new Audio XBMCResponse.audioPlaylist.result.items[0]
  
    it "has a title", () ->
      expect(@audio.get('title')).toEqual("Baba O'Riley")
  
    it "generates a thumbnail", () ->
      expect(@audio.thumbnailUrl()).toMatch('bba74b1e.tbn')
  
    it "produces a view-friendly object", () ->
      expect(_.keys(@audio.toView())).toEqual  ['title', 'artist', 'album', 'thumbnail', 'fanart', 'file', 'label', 'thumbnailUrl']
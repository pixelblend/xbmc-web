describe "Video", () ->
  describe "an empty object", () ->
    beforeEach () ->
      @video = new Video
    
    it "has default attributes", () ->
      expect(_.keys(@video.attributes)).toEqual
      ['title', 'director', 'duration', 'year', 'thumbnail']
      
  describe "a complete object", () ->
    beforeEach () ->
      @video = new Video XBMCResponse.videoPlaylist.result.items[0]
  
    it "has a title", () ->
      expect(@video.get('title')).toEqual("Toy Story")
  
    it "generates a thumbnail", () ->
      expect(@video.thumbnailUrl()).toMatch('bf2ab336.tbn')
  
    it "produces a view-friendly object", () ->
      expect(_.keys(@video.toView())).toEqual 
      ['title', 'director', 'duration', 'year', 'thumbnail', 'fanart', 'file', 'label', 'plot', 'thumbnailUrl']

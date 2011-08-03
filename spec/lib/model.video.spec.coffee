describe "Video", () ->
  describe "#type", () ->
    it "recognises a TV show", () ->
      @video = new Video
        episode: 1
        season: 1
        title: "Training Day"
        showtitle: "Archer (2009)"
      
      expect(@video.get('type')).toBe('tv')
      
    it "recognises a Film", () ->
      @video = new Video
        director: 'Quentin Tarantino'
        duration: 7222
        thumbnail: 'a379b384.tbn'
        title: 'Kill Bill Vol. 2'
        year: 2004

      expect(@video.get('type')).toBe('film')
    
    it "cannot recognise a non-library clip", () ->
      @video = new Video
        label: "New Music File.mkv"
        title: null
        season: null
      
      expect(@video.get('type')).toBeUndefined()

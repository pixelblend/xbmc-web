describe "Audio", () ->    
  describe "a non-music item", () ->    
    beforeEach () ->
      @audio = new Audio
        label: "AwesomeTrack.mp3"

    it "is not recognised as a music item", () ->
      expect(@audio.get('type')).toBeUndefined()
      
  describe "a music object", () ->
    beforeEach () ->
      @music = new Audio
        album: "Who's Next"
        artist: "The Who"
        file: "/Music/The Who/Who's Next/09 Won't Get Fooled Again.mp3"
        label: "09. The Who - Won't Get Fooled Again"
        thumbnail: "special://masterprofile/Thumbnails/Music/b/bba74b1e.tbn"
        title: "Won't Get Fooled Again"

    it "has a title", () ->
      expect(@music.get('title')).toEqual("Won't Get Fooled Again")
  
    it "generates a thumbnail", () ->
      expect(@music.get('thumbnail')).toMatch('.*(example.com).*(bba74b1e.tbn)')
    
    it "is recognised as a music item", () ->
      expect(@music.get('type')).toBe('music')
      

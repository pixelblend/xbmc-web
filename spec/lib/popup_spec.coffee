describe 'Popup', () ->
  beforeEach () ->
    loadFixtures('popup.html')
    @popup = new Popup
      collection: new AudioPlaylist
    
    spyOn(@popup, 'animate_titles')
    
    @track = new Music
      title: 'Moondance'
      artist: 'Van Morrison'
      thumbnail: 'cover.tbn'
    
  describe "with no media", () ->
    it "renders an empty view", () ->
      @popup.render()
      @canvas = $(@popup.el)
      
      expect(@popup.el.nodeName).toEqual('DIV')
      expect(@popup.el.id).toBe('now-playing')
      
      expect(@canvas.find('h1').text()).toBe('')
      expect(@canvas.find('h2').text()).toBe('')
  
  describe "rendered content", () ->
    beforeEach () ->
      @popup.collection.state = 'playing'
      @popup.collection.models = [@track]

      @popup.render()
      @canvas = $(@popup.el)
      
    describe "controls", () ->
      it "calls a trigger on the collection when clicked", () ->
        spyOn(@popup.collection, 'trigger')
        @canvas.find('a#next').click()
        expect(@popup.collection.trigger).toHaveBeenCalledWith('action:next')

      it "updates play / pause button with state", () ->
        expect(@canvas.find('a#play-pause').text()).toBe('Pause')

        @popup.collection.state = 'paused'
        @popup.collection.trigger('changed:state')

        expect(@canvas.find('a#play-pause').text()).toBe('Play')
      
  describe "with music playing", () ->
    beforeEach () ->   
      @popup.collection.state = 'playing'
      @popup.collection.models = [@track]

      @popup.render()
      @canvas = $(@popup.el)
    
    it "renders the current title", () ->
      expect(@canvas.find('h1').text()).toBe('Moondance')
    
    it "renders the current artist", () ->
      expect(@canvas.find('h2').text()).toBe('Van Morrison')
    
    it "renders a thumbnail of album cover", () ->
      expect(@canvas.find('img').attr('src')).toBe('http://example.com:8080/vfs/cover.tbn')
    
    it "animates the canvas", () ->
      expect(@popup.animate_titles).toHaveBeenCalled();
    
  describe "with video playing", () ->
    beforeEach () ->    
      @video = new Video
        director: 'Quentin Tarantino'
        duration: 93
        thumbnail: 'a379b384.tbn'
        title: 'Kill Bill Vol. 2'
        year: 2004
      
      @popup.collection = new VideoPlaylist
      @popup.collection.state = 'playing'
      @popup.collection.models = [@video]

      @popup.render()
      @canvas = $(@popup.el)
  
    it "renders the current title", () ->
      expect(@canvas.find('h1').text()).toBe('Kill Bill Vol. 2')
  
    it "renders the current director", () ->
      expect(@canvas.find('h2').text()).toBe('Dir. Quentin Tarantino')
      
    it "renders the current duration & year", () ->
      expect(@canvas.find('h3').text()).toBe('2004, 93 minutes')
  
    it "renders a thumbnail of poster", () ->
      expect(@canvas.find('img').attr('src')).toBe('http://example.com:8080/vfs/a379b384.tbn')
  
    it "animates the canvas", () ->
      expect(@popup.animate_titles).toHaveBeenCalled();
  
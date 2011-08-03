describe 'Popup', () ->
  beforeEach () ->
    loadFixtures('popup.html')
    @popup = new Popup
      collection: new AudioPlaylist
    
    spyOn(@popup, 'animateTitles')
    
    @track = new Audio
      title: 'Regular John'
      artist: 'Queens of the Stone Age'
      album: 'QOTSA'
      duration: 183
      thumbnail: 'qotsa.tbn'
    
  describe "with no media", () ->
    it "renders an empty view", () ->
      @popup.render()
      @canvas = $(@popup.el)
      expect(@popup.el.nodeName).toEqual('DIV')
      expect(@popup.el.id).toBe('now-playing')
      
      expect(@canvas.find('h1').text()).toBe('')
      expect(@canvas.find('h2')).toBeFalsy
  
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
      
  describe "with audio playing", () ->
    beforeEach () ->   
      @popup.collection.state = 'playing'
      @popup.collection.models = [@track]
      @popup.collection.length = 1
      
      @popup.render()
      @canvas = $(@popup.el)
    
    it "renders the current title", () ->
      expect(@canvas.find('h1 span').text()).toBe('Regular John')
    
    it "renders the current artist", () ->
      expect(@canvas.find('h2 span').text()).toBe('Queens of the Stone Age')
      
    it "renders the current album", () ->
      expect(@canvas.find('h3 span').text()).toBe('QOTSA')
      
    it "renders length of the current track", () ->
      expect(@canvas.find('h4 span').text()).toBe('3:03')
    
    it "renders a thumbnail of album cover", () ->
      expect(@canvas.find('img').attr('src')).toBe('http://example.com:8080/vfs/qotsa.tbn')
    
    it "animates the canvas", () ->
      expect(@popup.animateTitles).toHaveBeenCalled();
    
  describe "with video playing", () ->
    beforeEach () ->    
      @video = new Video
        director: 'Quentin Tarantino'
        duration: 7222
        thumbnail: 'a379b384.tbn'
        title: 'Kill Bill Vol. 2'
        year: 2004
      
      @popup.collection = new VideoPlaylist
      @popup.collection.state = 'playing'
      @popup.collection.models = [@video]
      @popup.collection.length = 1

      @popup.render()
      @canvas = $(@popup.el)
  
    it "renders the current title", () ->
      expect(@canvas.find('h1 span').text()).toBe('Kill Bill Vol. 2')
  
    it "renders the current director", () ->
      expect(@canvas.find('h2 span').text()).toBe('Dir. Quentin Tarantino')
      
    it "renders the current duration & year", () ->
      expect(@canvas.find('h3 span').text()).toBe('2004, 120:22')
  
    it "renders a thumbnail of poster", () ->
      expect(@canvas.find('img').attr('src')).toBe('http://example.com:8080/vfs/a379b384.tbn')
  
    it "animates the canvas", () ->
      expect(@popup.animateTitles).toHaveBeenCalled();
  
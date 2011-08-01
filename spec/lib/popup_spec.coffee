describe 'Popup', () ->
  beforeEach () ->
    loadFixtures('popup.html')
    @popup = new Popup
      collection: new AudioPlaylist
    
  describe "with no music", () ->
    it "renders an empty view", () ->
      @popup.render()
      @canvas = $(@popup.el)
      
      expect(@popup.el.nodeName).toEqual('DIV')
      expect(@popup.el.id).toBe('now-playing')
      
      expect(@canvas.find('h1').text()).toBe('')
      expect(@canvas.find('h2').text()).toBe('')
      
  describe "with music playing", () ->
    beforeEach () ->
      spyOn(@popup, 'animate_titles')
      
      @track = new Music
        title: 'Moondance'
        artist: 'Van Morrison'
        thumbnail: 'cover.tbn'
      
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

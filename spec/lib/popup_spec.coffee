describe 'Popup', () ->
  beforeEach () ->
    loadFixtures('popup.html')
    @popup = new Popup
      collection: new AudioPlaylist
  
  describe "with no music", () ->
    it "renders an empty tag", () ->
      @popup.render()
      @canvas = $(@popup.el)
          
      expect(@popup.el.nodeName).toEqual('DIV')
      expect(@popup.el.id).toBe('now_playing')
      expect(@canvas.find('h1').text()).toBe('')
      expect(@canvas.find('h2').text()).toBe('')
      
  describe "with music playing", () ->
    beforeEach () ->
      @track = new Music
        title: 'Moondance'
        artist: 'Van Morrison'
      
      @popup.collection.models = [@track]
      @popup.render()
      @canvas = $(@popup.el)
    
    it "renders the current title", () ->
      expect(@canvas.find('h1').text()).toBe('Moondance')
    
    it "renders the current artist", () ->
      expect(@canvas.find('h2').text()).toBe('Van Morrison')
      
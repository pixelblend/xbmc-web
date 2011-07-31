describe 'Popup', () ->
  beforeEach () ->
    @popup = new Popup
      collection: new AudioPlaylist
  
  describe "with no music", () ->
    it "renders an empty tag", () ->
      @popup.render()
      expect(@popup.el.nodeName).toEqual('H1')
      expect(@popup.el.id).toBe('now_playing')
      expect(@popup.el.innerHTML).toBe('')
      
  describe "with music playing", () ->
    beforeEach () ->
      @track = new Music
        title: 'Moondance'
        artist: 'Van Morrison'
      
      @popup.collection.models = [@track]
    
    it "renders title of current track", () ->
      @popup.render()
      expect(@popup.el.innerHTML).toBe('Moondance')
class window.AppController extends Backbone.Router  
  routes:
    '': 'index'
    'background': 'background'
    'options': 'options'
    'popup': 'popup'
  initialize: () ->
    location = $('body').attr('id')
    if location
      this.navigate(location, true)
  index: () ->
    console.error('#index - Nothing to happen here yet')
  background: () ->
    console.log('background')
    window.settings = new Settings    
    window.playlist = new AudioPlaylist
    
    port = chrome.extension.connect name: 'background'
    chrome.extension.onConnect.addListener (port) =>
      port.onMessage.addListener (msg) =>
        this.poll_playlist()
    
    this.poll_playlist()
  options: () ->
    console.log('options')
    window.settings = new Settings
    settings.fetch()
    window.options = new Options
      model: settings
    options.render()
  popup: () ->
    console.log('popup')
    window.popup = new Popup
      collection: chrome.extension.getBackgroundPage().playlist
    popup.render()
  poll_playlist: () ->
    settings.fetch()
    # console.log('polled on '+settings.get('host'))
    $(window).stop true
    $(window).everyTime 1000, () =>
      # console.log('polling '+settings.get('host'))
      playlist.fetch()

$ () ->
  window.controller = new AppController
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
    window.player   = new Player
    
    settings.fetch()
        
    $(window).everyTime 1000, () =>
      player.fetch()
      playlist.fetch()
    
    port = chrome.extension.connect name: 'background'
    chrome.extension.onConnect.addListener (port) =>
      port.onMessage.addListener (msg) =>
        settings.fetch()
        playlist.reset()
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

$ () ->
  window.controller = new AppController
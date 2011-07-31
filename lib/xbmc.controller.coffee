class window.AppController extends Backbone.Router  
  routes:
    '': 'index'
    'popup': 'popup'
    'background': 'background'
  initialize: () ->
    location = $('body').attr('id')
    if location
      this.navigate(location, true)
  index: () ->
    console.error('#index - Nothing to happen here yet')
  background: () =>
    console.log('background')
    window.settings = new Settings
    settings.fetch()
    
    window.playlist = new AudioPlaylist
    setInterval () ->
      playlist.fetch()
    , 1000
  popup: () ->
    console.log('popup')
    window.popup = new Popup
      collection: chrome.extension.getBackgroundPage().playlist
    popup.render()

$ () ->
  window.controller = new AppController
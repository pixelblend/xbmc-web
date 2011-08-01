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
    settings.fetch()
    
    window.playlist = new AudioPlaylist
    $(Backbone).stop true
    $(Backbone).everyTime 1000, () =>
      console.log('polling')
      playlist.fetch()
    
  options: () ->
    console.log('options')
    window.settings = new Settings
    settings.fetch()
    window.options = new Options model: settings
    options.render()
  popup: () ->
    console.log('popup')
    window.popup = new Popup
      collection: chrome.extension.getBackgroundPage().playlist
    popup.render()

$ () ->
  window.controller = new AppController
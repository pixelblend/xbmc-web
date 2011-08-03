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
    # console.log('background')
    window.settings = new Settings
    window.player   = new Player
    
    settings.fetch()
    
    #poll for xbmc data
    $(this).everyTime 1000, () =>
      try
        player.fetch()
      catch error
        console.error(error)
    
    #open port to communicate between options page and background
    port = chrome.extension.connect name: 'background'
    chrome.extension.onConnect.addListener (port) =>
      port.onMessage.addListener (msg) =>
        settings.fetch()
        player.playlist.reset()
  options: () ->
    # console.log('options')
    window.settings = new Settings
    settings.fetch()
    window.options = new Options
      model: settings
    options.render()
  popup: () ->
    console.log('popup')
    window.popup = new Popup
      player: chrome.extension.getBackgroundPage().player
    popup.render()

$ () ->
  window.controller = new AppController

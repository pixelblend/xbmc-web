xbmc.port =
  name: 'playlist'
  subscribe: () =>
    port = chrome.extension.connect({name: @name})
    chrome.extension.onConnect.addListener (port) ->
      port.onMessage.addListener (msg) ->
        xbmc.controller[msg]()
  publish: () =>
    xbmc.controller = chrome.extension.connect(name: @name)
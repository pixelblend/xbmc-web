if(typeof window.xbmc == 'undefined'){
  window.xbmc = {};
}

port = chrome.extension.connect({name: "playlist"});
chrome.extension.onConnect.addListener(function(port) {
  port.onMessage.addListener(function(msg) {
    xbmc.controller[msg]();
  });
});

xbmc.view = port;
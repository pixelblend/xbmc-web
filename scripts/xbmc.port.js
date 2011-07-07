if(typeof window.xbmc == 'undefined'){
  window.xbmc = {};
}

xbmc.port = {
    name: 'playlist'
  , subscribe: function(){
      port = chrome.extension.connect({name: this.name});
      chrome.extension.onConnect.addListener(function(port) {
        port.onMessage.addListener(function(msg) {
          xbmc.controller[msg]();
        });
      });
    }
  , publish: function(){
      xbmc.controller = chrome.extension.connect({name: this.name});
    }
}
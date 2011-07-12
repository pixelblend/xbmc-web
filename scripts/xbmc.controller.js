if(typeof window.xbmc == 'undefined'){
  window.xbmc = {};
}

xbmc.controller = {
    listArtists: function(){
      xbmc.model.query('AudioLibrary.GetArtists', function(result){
        $.each(result.artists, function(index,a) {
          $('<li>'+a.label+'</li>').appendTo('#artists');
        });
        }, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
    }

  , popup: function(msg){
      var views = chrome.extension.getViews({ type: "popup" });
      if(views.length == 1){
        var popup = views[0];
        popup.xbmc.view[msg]();
      }
    }
  , pollForState: function(){
      //stop previous polling
      $(self).stop(true);

      //clear playlist
      xbmc.store.clear();

      $(self).everyTime(1000, function(){
        xbmc.controller.playerState();
        xbmc.controller.playlist();
      });
    }
  , playerState: function(){
      xbmc.model.query('Player.GetActivePlayers', function(result){      
        refreshRequired = xbmc.store.playerType(result);
        if(refreshRequired){
          xbmc.controller.popup('refresh');
        }
      });
    }
  , playPause: function () {
      queryType = xbmc.store.buildMethod('Player.PlayPause');
      
      if(queryType === false){
        return false;
      }
      
      xbmc.model.query(queryType, function(result){
        //update view in popup
        xbmc.store.playerState(result);
        xbmc.controller.popup('setPlayState');
      });
    }
  , next: function(){
      queryType = xbmc.store.buildMethod('Player.SkipNext');
      
      xbmc.model.query(queryType, function(result){
        if(result === 'OK') {
          xbmc.controller.popup('setPlayState');
        }
      });
    }
  , playlist: function(){   
      queryType = xbmc.store.buildMethod("Playlist.GetItems");

      if(queryType == false){
        return false;
      }

      xbmc.model.query(queryType, function(result){
        newPlaylist = xbmc.store.playlist(result.items);
        
        newCurrent = xbmc.store.currentPosition(result.current);
        if(newPlaylist || newCurrent){
          xbmc.controller.popup('setNowPlaying');
        }
        
        stateChange = xbmc.store.playerState(result);
        if(stateChange){
          xbmc.controller.popup('setPlayState');
        }
      }, {'fields': xbmc.store.playlistFields()});
  }
  , previous: function(){
      queryType = xbmc.store.buildMethod('Player.SkipPrevious');
    
      xbmc.model.query(queryType, function(result){
        if(result === 'OK') {
          xbmc.controller.popup('setPlayState');
        }
      });
    }
  , stop: function(){
      queryType = xbmc.store.buildMethod('Player.stop');

      xbmc.model.query(queryType, function(result){
        if(result === 'OK') {
          xbmc.controller.popup('setPlayState');
        }
      });
    }
}

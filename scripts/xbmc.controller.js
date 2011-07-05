if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

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
	,	pollForState: function(){
			clearInterval(this.stateInterval);
			clearInterval(this.playerInterval);
			this.stateInterval  = setInterval('xbmc.controller.playerState()', xbmc.store.pollRate);
			this.playerInterval = setInterval('xbmc.controller.playlist()', xbmc.store.pollRate);
			this.playerInterval = setInterval('xbmc.controller.nowPlaying()', xbmc.store.pollRate);
		}
	,	playerState: function(){
 	    xbmc.model.query('Player.GetActivePlayers', function(result){
 				if(result.picture == true) {
 					playerType = 'picture';
 				} else if(result.video == true) {
 					playerType = 'video';
 				} else if(result.audio == true) {
 					playerType = 'audio';
 				} else {
 					playerType = 'stopped';
 				}
			
        localStorage.playerType = playerType;
        xbmc.controller.popup('setNowPlaying');
 			});
		}
	,	playPause: function () {
			queryType = xbmc.store.buildMethod('Player.PlayPause');
			
 	    if(queryType === false){
				return false;
			}
			
			xbmc.model.query(queryType, function(result){
				//update view in popup
				playState = xbmc.controller.fetchPlayStateFromResult(result);
				localStorage.state = playState;
				xbmc.controller.popup('setPlayStatus');
			});
		}
	,	next: function(){
			queryType = xbmc.store.buildMethod('Player.SkipNext');
			
			xbmc.model.query(queryType, function(result){
				if(result === 'OK') {
				  xbmc.controller.nowPlaying();
				}
			});
		}
	, nowPlaying: function(){
			if(xbmc.store.playerType() === 'stopped'){
				//stopped? dont bother running the request
				localStorage.playing = 'Stopped';
				localStorage.state = 'stopped';
				xbmc.controller.popup('setNowPlaying');
				return false;
			}
			
			xbmc.model.query('System.GetInfoLabels', function(result){
				xbmc.store.nowPlaying(result);
				xbmc.controller.popup('setNowPlaying');
				
			}, xbmc.store.nowPlayingFields());
		}
	, playlist: function(){ 	
 	    queryType = xbmc.store.buildMethod("Playlist.GetItems");

 	    if(queryType == false){
 	      return false;
 	    }

 	    xbmc.model.query(queryType, function(result){
        xbmc.store.playlist(result.items);
				state = xbmc.controller.fetchPlayStateFromResult(result);
				localStorage.state	= state;
				xbmc.store.currentPosition(result.current);
 	    });
	}
	, previous: function(){
  		queryType = xbmc.store.buildMethod('Player.SkipPrevious');
		
  		xbmc.model.query(queryType, function(result){
  			if(result === 'OK') {
  			  xbmc.controller.nowPlaying();
  			}
  		});
	  }
	, stop: function(){
  		queryType = xbmc.store.buildMethod('Player.stop');

  		xbmc.model.query(queryType, function(result){
  			if(result === 'OK') {
  			  xbmc.controller.nowPlaying();
  			}
  		});
	  }
	,	fetchPlayStateFromResult: function(result){
			var state;
			
			if(result.paused == true) {
				state = 'paused';
			} else if(result.playing == true) {
				state = 'playing';
			} else {
				state = 'stopped';
			}
			
			return state;
		}
}
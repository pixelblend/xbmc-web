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
	,	pollForState: function(){
			clearInterval(this.stateInterval);
			clearInterval(this.playerInterval);
			this.stateInterval  = setInterval('xbmc.controller.playerState()', xbmc.store.pollRate);
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
 			});
		}
	,	playPause: function () {
			queryType = xbmc.store.playPause();
			
 	    if(queryType === false){
				return false;
			}
			
			xbmc.model.query(queryType, function(result){
				//update view in popup
				playState = xbmc.controller.fetchPlayStateFromResult(result);
				localStorage.state = playState;
				xbmc.view.setPlayStatus();
			});
		}
	,	next: function(){
			queryType = xbmc.store.skipNext();
			
			xbmc.model.query(queryType, function(result){
				if(result === 'OK') {
				  xbmc.controller.nowPlaying();
				}
			});
		}
	, nowPlaying: function(){ 	
 	    queryType = xbmc.store.nowPlaying();

 	    if(queryType == false){
 	      return false;
 	    }

 	    xbmc.model.query(queryType, function(result){
        xbmc.store.playlist(result.items);
				state = xbmc.controller.fetchPlayStateFromResult(result);
				localStorage.state	= state;
				xbmc.store.currentPosition(result.current);

 	      localStorage.playing = xbmc.store.currentItem().label;
				xbmc.view.setNowPlaying();
 	    });
	}
	, previous: function(){
  		queryType = xbmc.store.skipPrevious();
		
  		xbmc.model.query(queryType, function(result){
  			if(result === 'OK') {
  			  xbmc.controller.nowPlaying();
  			}
  		});
	  }
	, stop: function(){
  		queryType = xbmc.store.stop();

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
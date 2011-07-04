if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.controller = {
		pollRate: 1000
	,	stateCall: {
        'video':   'VideoPlaylist.GetItems'
      , 'audio':   'AudioPlaylist.GetItems'
    }
	,	playPauseCall: {
      'video':   'VideoPlayer.PlayPause'
    , 'audio':   'AudioPlayer.PlayPause'		
		}
	,	listArtists: function(){
			xbmc.model.query('AudioLibrary.GetArtists', function(result){
	      $.each(result.artists, function(index,a) {
	        $('<li>'+a.label+'</li>').appendTo('#artists');
	      });
				}, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
		}
	,	pollForState: function(){
			clearInterval(this.stateInterval);
			clearInterval(this.playerInterval);
			this.stateInterval  = setInterval('xbmc.controller.playerState()', this.pollRate);
			this.playerInterval = setInterval('xbmc.controller.nowPlaying()', this.pollRate);
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
			queryType = this.playPauseCall[localStorage.playerType];
			
 	    if(typeof queryType == 'undefined'){
				return false;
			}
			
			xbmc.model.query(queryType, function(result){
				//update view in popup
			});
		}
	, nowPlaying: function(){ 	    
 	    queryType = this.stateCall[localStorage.playerType];
 	    
 	    if(typeof queryType == 'undefined'){
 	      localStorage.playList = [];
 	      localStorage.playing = '';
 	      return false;
 	    }
 	    
 	    xbmc.model.query(queryType, function(result){
        // localStorage.playList = result.items;
				if(result.paused == true) {
					state = 'paused';
				} else if(result.playing == true) {
					state = 'playing';
				} else {
					state = 'stopped';
				}
				
				localStorage.state	= state;

 	      localStorage.playing = result.items[result.current].label;
 	    });
	}
}
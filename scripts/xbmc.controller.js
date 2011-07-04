if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.controller = {
		pollRate: 1000
	,	listArtists: function(){
			xbmc.model.query('AudioLibrary.GetArtists', function(result){
	      $.each(result.artists, function(index,a) {
	        $('<li>'+a.label+'</li>').appendTo('#artists');
	      });
				}, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
		}
	,	pollForStatus: function(){
			clearInterval(this.stateInterval);
			clearInterval(this.playerInterval);
			this.stateInterval  = setInterval('xbmc.controller.playerState()', this.pollRate);
			this.playerInterval = setInterval('xbmc.controller.nowPlaying()', this.pollRate);
		}
	,	playerState: function(){
 	    xbmc.model.query('Player.GetActivePlayers', function(result){
   				var state;

   				if(result.picture == true) {
   					state = 'picture';
   				} else if(result.video == true) {
   					state = 'video';
   				} else if(result.audio == true) {
   					state = 'audio';
   				} else {
   					state = 'stopped';
   				}

           localStorage.state = state;
 			});
		}
	, nowPlaying: function(){
 	    var stateCall = {
 	        'video':   'VideoPlaylist.GetItems'
 	      , 'audio':   'AudioPlaylist.GetItems'
 	    };
 	    
 	    queryType = stateCall[localStorage.state];
 	    
 	    if(typeof queryType == 'undefined'){
 	      localStorage.playList = [];
 	      localStorage.playing = '';
 	      return false;
 	    }
 	    
 	    xbmc.model.query(queryType, function(result){
         // localStorage.playList = result.items;
 	      localStorage.playing = result.items[result.current].label;
 	    });
	}
}
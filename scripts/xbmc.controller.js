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
	,	playerState: function(){
  	  setInterval(function(){
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
  	  }, 1000);
		}
	, nowPlaying: function(){
  	  setInterval(function(){
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
  	  }, 1000);
	}
}
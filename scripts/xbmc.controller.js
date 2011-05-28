xbmc.controller = {
		listArtists: function(){
			xbmc.model.query('AudioLibrary.GetArtists', function(result){
	      $.each(result.artists, function(index,a) {
	        $('<li>'+a.label+'</li>').appendTo('#artists');
	      });
				}, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
		}
	,	playerState: function(callback){
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
				
				callback(state);
			});
		}
}
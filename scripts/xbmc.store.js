//localStorage is a nightmare to pull stuff out of. xbmc.store santises this data.
if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.store = {
		pollRate: 1000
	,	currentItem: function(){
			return this.playlist()[this.currentPosition()];
		}
	,	currentPosition: function(newCurrent){
			if(typeof newCurrent != 'undefined'){
				localStorage.current = newCurrent;
			} else if(typeof localStorage.playerType === 'undefined') {
				localStorage.current = false;
			}
			
			return parseInt(localStorage.current);
		}
	, buildMethod: function(method){
			switch(this.playerType()){
				case 'video':
					return 'Video'+method;
				case 'audio':
					return 'Audio'+method;
				default:
					return false;
			}
		}
	,	playlist: function(newPlaylist){
			if(typeof newPlaylist != 'undefined'){
				localStorage.playlist = JSON.stringify(newPlaylist);
			} else if(typeof localStorage.playlist === 'undefined') {
				localStorage.playlist = JSON.stringify([]);
			}
			
			return $.parseJSON(localStorage.playlist);
		}
	,	playerType: function(newType){
			if(typeof newType != 'undefined'){
				localStorage.playerType = newType;
			} else if(typeof localStorage.playerType === 'undefined') {
				localStorage.playerType = false;
			}
			
			return localStorage.playerType;
		}
};
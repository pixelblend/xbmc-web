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
	,	nowPlaying: function(){
			switch(this.playerType()){
				case 'video':
					return 'VideoPlaylist.GetItems';
				case 'audio':
					return 'AudioPlaylist.GetItems';
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
	,	playPause: function(){
			switch(this.playerType()){
				case 'video':
					return 'VideoPlayer.PlayPause';
				case 'audio':
					return 'AudioPlayer.PlayPause';
				default:
					return false;
			}		
		}
	,	playerType: function(newType){
			if(typeof newType != 'undefined'){
				localStorage.playerType = newType;
			} else if(typeof localStorage.playerType === 'undefined') {
				localStorage.playerType = false;
			}
			
			return localStorage.playerType;
		}
	,	skipNext: function(){
			switch(this.playerType()){
				case 'video':
					return 'VideoPlayer.SkipNext';
				case 'audio':
					return 'AudioPlayer.SkipNext';
				default:
					return false;
			}		
		}
	,	skipPrevious: function(){
			switch(this.playerType()){
				case 'video':
					return 'VideoPlayer.SkipPrevious';
				case 'audio':
					return 'AudioPlayer.SkipPrevious';
				default:
					return false;
			}		
		}
	,	stop: function(){
			switch(this.playerType()){
				case 'video':
					return 'VideoPlayer.stop';
				case 'audio':
					return 'AudioPlayer.stop';
				default:
					return false;
			}		
		}
};
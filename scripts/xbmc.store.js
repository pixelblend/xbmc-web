if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.store = {
		pollRate: 1000
	,	currentItem: function(){
			return this.playlist()[this.currentPosition()];
		}
	,	currentPosition: function(newCurrent){
			if(typeof newCurrent != 'undefined'){
				localStorage.current = parseInt(newCurrent);
			} else if(typeof localStorage.playerType === 'undefined') {
				localStorage.current = false;
			}
			
			return localStorage.current;
		}
	, incrementCurrent: function(){
			current = this.currentPosition();
			current = (current == false ? false : current + 1);
			return this.currentPosition(current);
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
};
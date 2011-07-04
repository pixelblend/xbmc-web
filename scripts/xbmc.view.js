if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._state();
		}
	,	setPlayStatus: function(){
			state = localStorage.state;
			label = (state == 'stopped' || state == 'paused') ? 'Play' : 'Pause';
			$('#play-pause').text(label);
		}
	, setNowPlaying: function(){
			$('#now-playing').text(localStorage.playing);
		}
	,	_canvas: function(){
			//playlist
			$('<div/>', {id: 'player-status'}).appendTo('body');
			$('<h3/>',  {text: 'Now Playing:'}).appendTo('#player-status');
			$('<div/>', {id: 'now-playing'}).appendTo('#player-status');
			
			//interface
			$('<div/>', {id: 'controls'}).appendTo('body');
		}
	,	_buttons: function(){
			var buttons = {'prev': 'Back', 'stop': 'Stop', 'play-pause':'Play', 'next': 'Next'};
			$.each(buttons, function(id, label){
				$('<a/>', {id: id, text: label, href: '#'}).appendTo('#controls');
			});
			
			$('#play-pause').click(function(){
				xbmc.controller.playPause();
			});
			$('#next').click(function(){
				xbmc.controller.next();
			});
		}
	,	_state: function(){
			var playerType = localStorage.playerType;
	    if(typeof playerType == 'undefined'){
				$('#play-pause').text('Play');
				$('#now-playing').text('Could not connect.');
	    } else {
				xbmc.view.setPlayStatus();
				xbmc.view.setNowPlaying();
			}
		}
};
if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._state();
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
			var buttons = {'prev': 'Back', 'stop': 'Stop', 'play-pause':'Play/Pause', 'forward': 'Forward'};
			$.each(buttons, function(id, label){
				$('<a/>', {id: id, text: label, href: '#'}).appendTo('#controls');
			});
			
			$('#play-pause').click(function(){
				xbmc.controller.playPause();
			});
		}
	,	_state: function(){
  	  var state = localStorage.state;
			var playerType = localStorage.playerType;
			console.log(state);
	    if(typeof playerType == 'undefined'){
				$('#play-pause').text('Play');
				$('#now-playing').text('Could not connect.');
	    } else {
				$('#play-pause').text((state == 'stopped' || state == 'paused') ? 'Play' : 'Pause');
				$('#now-playing').text(localStorage.playing);
			}
		}
};
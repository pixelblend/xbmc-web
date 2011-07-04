if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._state();
		}
	,	_canvas: function(){
			$('<div/>', {id: 'controls'}).appendTo('body');
		}
	,	_buttons: function(){
			var buttons = {'prev': 'Back', 'stop': 'Stop', 'play-pause':'Play/Pause', 'forward': 'Forward'};
			$.each(buttons, function(id, label){
				$('<a/>', {id: id, text: label, href: '#'}).appendTo('#controls');
			});
		}
	,	_state: function(){
  	  var state = localStorage.state;
	    if(typeof state == 'undefined'){
	      return;
	    }
			$('#play-pause').text(state == 'stopped' ? 'Play' : 'Pause');
			$('<h3/>', {text: localStorage.playing}).appendTo('body');
		}
};
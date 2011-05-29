xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._state();
			this._linkToIndex();
		}
	,	_canvas: function(){
			$('<div/>', {id: 'controls'}).appendTo('body');
			$('<div/>', {id: 'state', text: 'Loading...'}).appendTo('body');
		}
	,	_buttons: function(){
			var buttons = {'prev': 'Back', 'stop': 'Stop', 'play-pause':'Play/Pause', 'forward': 'Forward'};
			$.each(buttons, function(id, label){
				$('<a/>', {id: id, text: label, href: '#'}).appendTo('#controls');
			});
		}
	,	_state: function(){
			xbmc.controller.playerState(function(state){
				$('#state').text(state);
				$('#play-pause').text(state == 'stopped' ? 'Play' : 'Pause');
			});
		}
	,	_linkToIndex: function(){
			$('<a/>', {onClick: "chrome.tabs.create({url: 'index.html'})", text: 'Index', href: "#"}).appendTo('body');
		}
};
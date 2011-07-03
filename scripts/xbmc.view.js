if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._linkToIndex();
			this._state();
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
  	  var state = localStorage.state;
	    if(typeof state == 'undefined'){
	      return;
	    }
			$('#state').text(state);
			$('#play-pause').text(state == 'stopped' ? 'Play' : 'Pause');
			$('<h3/>', {text: localStorage.playing}).appendTo('body');
		}
	,	_linkToIndex: function(){
			$('<a/>', {onClick: "chrome.tabs.create({url: 'index.html'})", text: 'Index', href: "#"}).appendTo('body');
		}
};
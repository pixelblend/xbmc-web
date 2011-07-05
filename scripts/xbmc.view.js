if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.view = {
		controls: function(){
			this._canvas();
			this._buttons();
			this._state();
		}
	, refresh: function(){
	    this.setPlayStatus();
	    this.setNowPlaying();
	  }
	,	setPlayStatus: function(){
			state = localStorage.state;
			switch(state){
			  case 'stopped':
  		    $('#controls').hide();
  		    $('#thumb').hide();
			    break;
  	    case 'paused':
		      $('#thumb').show();
  	      $('#controls').show();
  	      $('#play-pause').text('Play');
  	      break;
	      default:
  	      $('#thumb').show();
  	      $('#controls').show();
  	      $('#play-pause').text('Pause');
			}
		}
	, setNowPlaying: function(){
      $('#now-playing-text').html(xbmc.store.nowPlaying());
      $('#thumb').attr('src',xbmc.store.currentThumbnail());
		}
	,	_canvas: function(){
			//playlist
			$('<div/>', {id: 'player-status'}).appendTo('body');
			
			//now playing			
			$('<div/>', {id: 'now-playing'}).appendTo('#player-status');
			$('<img/>', {id: 'thumb'}).appendTo('#now-playing');
			$('<div/>', {id: 'now-playing-text'}).appendTo('#now-playing');
			
			//interface
			$('<div/>', {id: 'controls'}).appendTo('body');
		}
	,	_buttons: function(){
			var buttons = {'prev': 'Back', 'stop': 'Stop', 'play-pause':'Play', 'next': 'Next'};
			$.each(buttons, function(id, label){
				$('<a/>', {id: id, text: label, href: '#'}).appendTo('#controls');
			});
			
			$('#play-pause').click(function(){
			  xbmc.controller.postMessage('playPause');
			});
			$('#prev').click(function(){
			  xbmc.controller.postMessage('previous');
			});
			$('#next').click(function(){
			  xbmc.controller.postMessage('next');
			});
			$('#stop').click(function(){
			  xbmc.controller.postMessage('stop');
			});
		}
	,	_state: function(){
			var playerType = xbmc.store.playerType();
	    if(playerType === false){
				$('#play-pause').text('Play');
				$('#now-playing').text('Could not connect.');
	    } else {
				xbmc.view.setPlayStatus();
				xbmc.view.setNowPlaying();
			}
		}
};
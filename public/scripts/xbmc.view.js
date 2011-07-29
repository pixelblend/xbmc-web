if(typeof window.xbmc == 'undefined'){
  window.xbmc = {};
}

xbmc.view = {
    controls: function(){
      this._canvas();
      this._buttons();
      this._state();
    }
  , refresh: function(){
      this.setPlayState();
      this.setNowPlaying();
    }
  , setPlayState: function(){
      state = xbmc.store.playerState();

      switch(state){
        case 'stopped':
        case 'paused':
          $('#play-pause').text('Play');
          $('#player-state').attr('class', state+' '+xbmc.store.playerType());
          break;
        default:
          $('#player-state').attr('class', 'playing '+xbmc.store.playerType());
          $('#play-pause').text('Pause');
      }
    }
  , setNowPlaying: function(){
      nowPlaying = xbmc.store.nowPlaying();

      $('#thumb img').attr('src', xbmc.store.currentThumbnail());

      $('#now-playing-text h1 span').html(nowPlaying[0]);
      $('#now-playing-text h2 span').html(nowPlaying[1]);
      $('#now-playing-text h3 span').html(nowPlaying[2]);
      this.animateTitles();
    }
  , animateTitles: function(){
      var maxWidth = $('#now-playing-text').width();

      $('#now-playing-text span').each(function(){
        $(this).stop(true).css('left',0);
        
        var offset = 5;
        var scrollTime = 3000;
        var holdTime = 1000;
        
        $(this).everyTime(5, function(){
          if($(this).width() > maxWidth-offset) {
            var scrollLength = '-'+(($(this).width()-maxWidth)+offset);
            $(this).animate({left: scrollLength}, scrollTime).animate({left: scrollLength}, holdTime).animate({left:0}, scrollTime).animate({left:0}, holdTime);
          } else {
            $(this).stop(true).css('left',0);
          }
        });
      });
    }
  , _canvas: function(){
      //playlist
      $('<div/>', {id: 'player-state'}).appendTo('body');
      //interface
      $('<div/>', {id: 'controls'}).appendTo('#player-state');
      
      //now playing     
      $('<div/>', {id: 'now-playing'}).appendTo('#player-state');
      $('<div/>', {id: 'thumb'}).appendTo('#now-playing');
      $('<img/>').appendTo('#thumb');

      $('<div/>', {id: 'now-playing-text'}).appendTo('#now-playing');
      $('<h1><span></span></h1>').appendTo('#now-playing-text');
      $('<h2><span></span></h2>').appendTo('#now-playing-text');
      $('<h3><span></span></h3>').appendTo('#now-playing-text');

      // $('<div/>', {id: 'playlist'}).appendTo('body');
      
    }
  , _buttons: function(){
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
  , _state: function(){
      var playerType = xbmc.store.playerType();
      if(playerType === false){
        $('#play-pause').text('Play');
        $('#now-playing').text('Could not connect.');
      } else {
        xbmc.view.setPlayState();
        xbmc.view.setNowPlaying();
      }
    }
};
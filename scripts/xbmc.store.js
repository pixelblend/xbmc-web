//localStorage is a nightmare to pull stuff out of. xbmc.store santises this data.
if(typeof window.xbmc == 'undefined'){
  window.xbmc = {};
}

xbmc.store = {
      _playlistFields: {
          'audio': ['artist', 'title', 'album', 'cover']
        , 'video': ['title', 'season', 'episode', 'plot', 'duration', 'showtitle', 'year', 'director', 'cast']
      }
    , buildMethod: function(method){
        switch(this.playerType()){
          case 'video':
            return 'Video'+method;
          case 'audio':
            return 'Audio'+method;
          case 'picture':
            if(method.search('Playlist') == -1){
              return 'Picture'+method;
            } else {
              return false;
            }
          case 'stopped':
            return false;
          default:
            console.error("store.buildMethod: unexpected playerType "+xbmc.store.playerType()+" for "+method);
            return false;
        }
      }
  , currentItem: function(){
      return this.playlist()[this.currentPosition()];
    }
  , currentPosition: function(newCurrent){
      if(typeof localStorage.playerType === 'undefined') {
        localStorage.current = false;
      }
      
      oldCurrent = localStorage.current;
      
      if(typeof newCurrent === 'undefined'){
        return parseInt(oldCurrent);
      } else {
        localStorage.current = newCurrent;
        return (oldCurrent != newCurrent);
      }
    }
  , currentThumbnail: function(){
      thumbnail = this.currentItem().thumbnail;
      if(thumbnail == 'DefaultAlbumCover.png'){
        return '/images/'+thumbnail;
      }
    
      return xbmc.options.url()+'/vfs/'+thumbnail;
    }
  , nowPlaying: function(){
      var nowPlaying = [];
      var result = this.currentItem();
      
      switch(this.playerType()) {
        case 'audio':
          nowPlaying = [result['title'], result['artist'], result['album']];
          break;
        case 'video':
          var moreInfo;
          //no title? not a library file, just display label
          if(typeof result['title'] === 'undefined'){
            nowPlaying = [result['label'], '', ''];
            break;
          }
          
          if(typeof result['showtitle'] === 'undefined'){
            moreInfo = 'Dir: '+result['director']+', '+result['year'];
          } else {
            moreInfo = result['showtitle']+' '+result['season']+'x'+result['episode'];
          }
          nowPlaying = [result['title'], moreInfo, (parseInt(result['duration'])/60).toFixed(0)+' Minutes'];
          break;
        case 'picture':
          nowPlaying= ['Picture Slideshow', '', ''];
          break;
        case 'stopped':
          nowPlaying = ['Stopped', '', ''];
          break;
        default:
          console.error("store.nowPlaying: unexpected playerType "+xbmc.store.playerType());
      }
      return nowPlaying;
    }
  , playlist: function(newPlaylist){      
      if(typeof newPlaylist === 'undefined'){
        return $.parseJSON(localStorage.playlist);
      } else if(typeof localStorage.playlist === 'undefined') {
        localStorage.playlist = JSON.stringify([]);
      }
      
      currentPlaylist = localStorage.playlist;
      localStorage.playlist = JSON.stringify(newPlaylist);
      
      return (currentPlaylist != localStorage.playlist);
    }
  , playlistFields: function(){
      return this._playlistFields[this.playerType()];
    }
  , playerType: function(result){
      currentType = localStorage.playerType;
      
      if(typeof currentType === 'undefined') {
        localStorage.playerType = 'stopped';
      }
    
      if(typeof result === 'undefined'){
        return localStorage.playerType;
      }
      
      switch(true) {
        case result.video:
          newType = 'video';
          break;
        case result.audio:
          newType = 'audio';
          break;
        case result.picture:
          newType = 'picture';
          break;
        default:
          newType = 'stopped';
      }
      
      localStorage.playerType = newType;
      return (newType != currentType);
    }
  , playerState: function(result){
      oldState = localStorage.state;
      
      switch(true){
        case (typeof result === 'undefined') && this.playerType() === 'picture':
          return 'playing';
        case (typeof result === 'undefined'):
          return oldState;
        case result.paused:
          newState = 'paused';
          break;
        case result.playing:
          newState = 'playing';
          break;
        default:
          newState = 'stopped';
      }
      
      localStorage.state = newState;
      return (oldState != newState);
    }
};
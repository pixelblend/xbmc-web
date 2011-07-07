//localStorage is a nightmare to pull stuff out of. xbmc.store santises this data.
if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.store = {
    pollRate: 2000
    , buildMethod: function(method){
        switch(this.playerType()){
          case 'video':
            return 'Video'+method;
          case 'audio':
            return 'Audio'+method;
          default:
            console.error("store.buildMethod: unexpected playerType "+xbmc.store.playerType());
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
  , nowPlaying: function(result){
      wasPlaying = localStorage.playing;
      
      if(typeof result === 'undefined'){
        return $.parseJSON(wasPlaying);
      }
      
      var nowPlaying = [];
      
      switch(this.playerType()) {
        case 'audio':
          nowPlaying = [result['MusicPlayer.Title'], result['MusicPlayer.Artist'], result['MusicPlayer.Album']];
          break;
        case 'video':
          var moreInfo;
          result = result.items[0];
          
          //no title? not a library file, just display label
          if(typeof result['title'] === 'undefined'){
            nowPlaying = [result['label']];
            break;
          }
          
          if(typeof result['showtitle'] === 'undefined'){
            moreInfo = 'Dir: '+result['director']+', '+result['year'];
          } else {
            moreInfo = result['showtitle']+' '+result['season']+'x'+result['episode'];
          }
          nowPlaying = [result['title'], moreInfo, (parseInt(result['duration'])/60).toFixed(0)+' Minutes'];
          break;
        case 'stopped':
          nowPlaying = ['Stopped'];
          break;
        default:
          console.error("store.nowPlaying: unexpected playerType "+xbmc.store.playerType());
      }
      
      localStorage.playing = JSON.stringify(nowPlaying);
      return(localStorage.playing != wasPlaying)
    }
  , playlist: function(newPlaylist){
      if(typeof newPlaylist != 'undefined'){
        localStorage.playlist = JSON.stringify(newPlaylist);
      } else if(typeof localStorage.playlist === 'undefined') {
        localStorage.playlist = JSON.stringify([]);
      }
      
      return $.parseJSON(localStorage.playlist);
    }
  , playerType: function(newType){
      currentType = localStorage.playerType;
      
      if(typeof currentType === 'undefined') {
        localStorage.playerType = false;
      }
    
      if(typeof newType === 'undefined'){
        return localStorage.playerType;
      }
      
      if(newType != currentType){
        localStorage.playerType = newType;
        return true
      } else {
        return false;
      }
    }
  , playerState: function(newState){
      oldState = localStorage.state;
      if(typeof newState == 'undefined'){
        return oldState;
      } else {
        localStorage.state = newState;
        return (oldState != newState);
      }
    }
};
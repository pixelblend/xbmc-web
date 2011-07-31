class window.Media extends Backbone.Model
  
class window.Music extends Media
  thumbnail: () ->
    thumbnail = this.get('thumbnail')
    if thumbnail == 'DefaultAlbumCover.png'
      "/images/#{thumbnail}"
    else
    "http://xbmc:xbmc@localhost:8080/vfs/#{thumbnail}"
    
class window.Video extends Media
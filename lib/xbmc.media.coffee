class window.Media extends Backbone.Model
  
class window.Music extends Media
  defaults: () ->
    title: ''
    artist: ''
    album: ''
    thumbnail: 'DefaultAlbumCover.png'
  thumbnail: () ->
    thumbnail = this.get('thumbnail')
    if thumbnail == 'DefaultAlbumCover.png'
      "/images/#{thumbnail}"
    else
    "http://xbmc:xbmc@localhost:8080/vfs/#{thumbnail}"
  to_view: () ->
    attrs = this.attributes
    attrs.thumbnail = this.thumbnail()
    attrs
    
class window.Video extends Media
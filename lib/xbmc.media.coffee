class window.Media extends Backbone.Model
  
class window.Music extends Media
  defaults: () ->
    title: ''
    artist: ''
    album: ''
    thumbnail: ''
  thumbnail: () ->
    thumbnail = this.get('thumbnail')
    if thumbnail == 'DefaultAlbumCover.png'
      "/images/#{thumbnail}"
    else
    "#{settings.url()}/vfs/#{thumbnail}"
  to_view: () ->
    attrs = this.attributes
    attrs.thumbnail = this.thumbnail()
    attrs
    
class window.Video extends Media
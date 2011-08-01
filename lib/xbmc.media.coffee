class window.Media extends Backbone.Model
  
class window.Music extends Media
  defaults: () ->
    title: ''
    artist: ''
    album: ''
    thumbnail: 'DefaultAlbumCover.png'
  thumbnail_url: () ->
    thumbnail = this.get('thumbnail')
    if thumbnail.indexOf('.tbn') > -1
      "#{settings.url()}/vfs/#{thumbnail}"
    else
      "/images/#{thumbnail}"
  to_view: () ->
    attrs = this.attributes
    attrs.thumbnail_url = this.thumbnail_url()
    attrs.title = this.attributes.title || this.attributes.label
    attrs

class window.Video extends Media

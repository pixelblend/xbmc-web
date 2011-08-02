class window.Media extends Backbone.Model
  thumbnailUrl: () ->
    thumbnail = this.get('thumbnail')
    if thumbnail.indexOf('.tbn') > -1
      "#{settings.url()}/vfs/#{thumbnail}"
    else
      "/images/#{thumbnail}"
  toView: () ->
    attrs = this.attributes
    attrs.thumbnailUrl = this.thumbnailUrl()
    attrs.title = this.attributes.title || this.attributes.label
    attrs
  
class window.Music extends Media
  defaults: () ->
    title: ''
    artist: ''
    album: ''
    thumbnail: 'DefaultAlbumCover.png'

class window.Video extends Media
  defaults: () ->
    title: ''
    director: ''
    duration: ''
    year: ''
    thumbnail: 'DefaultAlbumCover.png'
  
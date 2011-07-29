class window.Media extends Backbone.Model
  thumbnail: () ->
    "#{this.get('title')} - #{this.get('artist')}.jpg"

class window.Music extends Media

class window.Video extends Media
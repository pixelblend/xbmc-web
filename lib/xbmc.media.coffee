class window.Media extends Backbone.Model
  
class window.Music extends Media
  thumbnail: () ->
    "#{this.get('title')} - #{this.get('artist')}.jpg"

class window.Video extends Media
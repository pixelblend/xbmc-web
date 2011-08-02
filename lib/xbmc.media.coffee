class window.Media extends Backbone.Model
  durationToMinutes: (duration) ->
    minutes = Math.floor(duration / 60)
    seconds = Math.floor(duration % 60)
    seconds = "0#{seconds}" if seconds < 9
    "#{minutes}:#{seconds}"
  thumbnailUrl: (thumbnail) ->
    if thumbnail.indexOf('.tbn') > -1
      "#{settings.url()}/vfs/#{thumbnail}"
    else
      "/images/#{thumbnail}"
  initialize: () =>
    this.set 
      thumbnail: this.thumbnailUrl(this.get('thumbnail'))
      durationMinutes: this.durationToMinutes(this.get('duration'))
  defaults: () ->
    title: null
    artist: null
    album: null
    director: null
    duration: null
    year: null
    episode: null
    season: null
    thumbnail: 'DefaultAlbumCover.png'
  
class window.Audio extends Media
  initialize: () ->
    super
    this.set type: 'music' if this.has('artist')  

class window.Video extends Media
  initialize: () ->
    super
    switch true
      when this.has('season') and this.has('episode')
        type = 'tv'
      when this.has('director')
        type = 'film'
    this.set type: type

class window.PlaylistCollection extends Backbone.Collection
  model: Media
  url: 'Playlist.GetItems'
  sync: Backbone.playlist_sync
  method: () ->
    "#{this.media}#{this.url}"
  now_playing: () ->
    this.models[this.current]
  current: 0
  state: 'stopped'

class window.AudioPlaylist extends PlaylistCollection
  media: 'Audio'
  model: Music
  fields: ['artist', 'title', 'album', 'cover']

class window.VideoPlaylist extends PlaylistCollection
  media: 'Video'
  model: Video
  fields: ['title', 'season', 'episode', 'plot', 'duration', 'showtitle', 'year', 'director', 'cast']
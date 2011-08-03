class window.PlaylistCollection extends Backbone.Collection
  method: () ->
    "#{this.model.name}#{this.url}"
  nowPlaying: () ->
    this.at(this.current)
  model: Media
  url: 'Playlist.GetItems'
  sync: Backbone.playlistSync
  initialize: () ->
    this.state = 'stopped'
    this.current = 0

class window.AudioPlaylist extends PlaylistCollection
  model: Audio
  fields: ['artist', 'title', 'album', 'duration']

class window.VideoPlaylist extends PlaylistCollection
  model: Video
  fields: ['title', 'season', 'episode', 'plot', 'duration', 'showtitle', 'year', 'director', 'cast']

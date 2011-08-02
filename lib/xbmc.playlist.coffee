class window.PlaylistCollection extends Backbone.Collection
  method: () ->
    "#{this.media}#{this.url}"
  nowPlaying: () ->
    this.at(this.current)
  model: Media
  url: 'Playlist.GetItems'
  sync: Backbone.playlistSync
  initialize: () ->
    this.state = 'stopped'
    this.current = 0

class window.AudioPlaylist extends PlaylistCollection
  model: Music
  media: 'Audio'
  fields: ['artist', 'title', 'album']

class window.VideoPlaylist extends PlaylistCollection
  model: Video
  media: 'Video'
  fields: ['title', 'season', 'episode', 'plot', 'duration', 'showtitle', 'year', 'director', 'cast']

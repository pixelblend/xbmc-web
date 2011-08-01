class window.PlaylistCollection extends Backbone.Collection
  method: () ->
    "#{this.media}#{this.url}"
  now_playing: () ->
    this.models[this.current]
  model: Media
  current: 0
  state: 'stopped'
  url: 'Playlist.GetItems'
  sync: Backbone.playlist_sync

class window.AudioPlaylist extends PlaylistCollection
  media: 'Audio'
  model: Music
  fields: ['artist', 'title', 'album']

class window.VideoPlaylist extends PlaylistCollection
  media: 'Video'
  model: Video
  fields: ['title', 'season', 'episode', 'plot', 'duration', 'showtitle', 'year', 'director', 'cast']
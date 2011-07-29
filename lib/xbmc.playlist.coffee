class window.PlaylistCollection extends Backbone.Collection
  model: Media
  url: 'Playlist.GetItems'
  sync: Backbone.playlist_sync
  method: () ->
    "#{this.media}#{this.url}"
  now_playing: () ->
    this.models[this.current]
  current: 0

class window.VideoPlaylist extends PlaylistCollection
  media: 'Video'

class window.AudioPlaylist extends PlaylistCollection
  media: 'Audio'
  fields: ['artist', 'title', 'album', 'cover']

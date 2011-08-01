class window.Player extends Backbone.Model
  defaults:
    media: 'Audio'
  sync: Backbone.player_sync
  initialize: (playlist) ->
    this.playlist = playlist
    
    this.playlist.bind 'action:prev', () =>
      this.fetch action: this.get('media')+'Player.SkipPrevious'
    this.playlist.bind 'action:next', () =>
      this.fetch action: this.get('media')+'Player.SkipNext'
    this.playlist.bind 'action:play-pause', () =>
      this.fetch action: this.get('media')+'Player.PlayPause'
    this.playlist.bind 'action:stop', () =>
      this.fetch action: this.get('media')+'Player.stop'

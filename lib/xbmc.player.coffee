class window.Player extends Backbone.Model
  defaults:
    state: 'stopped'
  sync: Backbone.playerSync
  initialize: () ->
    this.bind 'change:state', () ->
      this.playlist = switch this.get('state')
        when 'audio' 
          new AudioPlaylist 
        when 'video'
          new VideoPlaylist
        when 'stopped'
          new PlaylistCollection
        else
          console.error "Player: unknown state #{this.get('state')}"
          new PlaylistCollection
      this.bindPlaylist()

  bindPlaylist: () ->
    currentState = this.get('state')
    return false if currentState == 'stopped'
    this.playlist.bind 'action:prev', () =>
      this.fetch action: currentState+'Player.SkipPrevious'
    this.playlist.bind 'action:next', () =>
      this.fetch action: currentState+'Player.SkipNext'
    this.playlist.bind 'action:play-pause', () =>
      this.fetch action: currentState+'Player.PlayPause'
    this.playlist.bind 'action:stop', () =>
      this.fetch action: currentState+'Player.stop'
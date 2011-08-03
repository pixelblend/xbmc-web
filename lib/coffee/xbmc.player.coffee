class window.Player extends Backbone.Model
  defaults:
    state: 'stopped'
  sync: Backbone.playerSync
  initialize: () ->
    this.bind 'change:state', () ->
      currentState = this.get 'state'
      this.playlist = switch currentState
        when 'audio' 
          new AudioPlaylist 
        when 'video'
          new VideoPlaylist
        when 'stopped'
          undefined
        else
          console.error "Player: unknown state #{currentState}"
          undefined

      this.trigger('changed:playlist')
      this.bindPlaylist(currentState) if this.playlist
  bindPlaylist: (currentState) ->
    this.playlist.bind 'action:prev', () =>
      this.fetch action: currentState+'Player.SkipPrevious'
    this.playlist.bind 'action:next', () =>
      this.fetch action: currentState+'Player.SkipNext'
    this.playlist.bind 'action:play-pause', () =>
      this.fetch action: currentState+'Player.PlayPause'
    this.playlist.bind 'action:stop', () =>
      this.fetch action: currentState+'Player.stop'
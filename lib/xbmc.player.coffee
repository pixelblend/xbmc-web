class window.Player extends Backbone.Model
  defaults:
    state: 'stopped'
  sync: Backbone.player_sync
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
      this.bind_playlist()

  bind_playlist: () ->
    current_state = this.get('state')
    return false if current_state == 'stopped'
    this.playlist.bind 'action:prev', () =>
      this.fetch action: current_state+'Player.SkipPrevious'
    this.playlist.bind 'action:next', () =>
      this.fetch action: current_state+'Player.SkipNext'
    this.playlist.bind 'action:play-pause', () =>
      this.fetch action: current_state+'Player.PlayPause'
    this.playlist.bind 'action:stop', () =>
      this.fetch action: current_state+'Player.stop'
class window.Player extends Backbone.Model
  url:  'Player.GetActivePlayers'
  sync: Backbone.player_sync
  defaults:
    media: 'stopped'
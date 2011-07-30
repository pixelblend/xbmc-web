Backbone.sync_id = () ->
  @id = @id || 0
  @id++
  
Backbone.xbmc_call = (method, model, options) ->
  $.ajax
    type: 'POST'
    username: 'xbmc'
    password: 'xbmc'
    async: true
    url: 'http://localhost:8080/jsonrpc'
    cache: false
    dataType: 'json'
    data: """
          {"jsonrpc": "2.0", "method": "#{options.method}", 
            "params": 
              #{JSON.stringify(options.params)}, 
            "id": #{Backbone.sync_id()}}"
          """
            
    error: (xhr, textStatus, errorThrown) ->
      options.error(xhr, textStatus, errorThrown)
    success: (response) ->
      options.success(response.result)
  
Backbone.playlist_sync = (method, playlist, options) =>
  options.default_success = options.success
  options.method = playlist.method()
  options.params = {"fields": playlist.fields}

  options.success = (result) ->
    options.default_success(result.items)
    playlist.current = result.current
    playlist.state = switch true
      when result.paused  then 'paused' 
      when result.playing then 'playing'
      else 'stopped'
    
  Backbone.xbmc_call(method, playlist, options)

Backbone.player_sync = (method, player, options) =>
  options.method = player.url
  options.params = ''
  
  options.success = (result) ->    
    new_state = switch true 
      when result.audio then 'audio'
      when result.video then 'video'
      when result.picture then 'picture'
      else 'stopped'
    
    player.set({media: new_state})

  Backbone.xbmc_call(method, player, options)

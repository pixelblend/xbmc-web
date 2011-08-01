Backbone.sync_id = () ->
  @id = @id || 0
  @id++
  
Backbone.xbmc_call = (method, model, options) ->
  # console.log(options.method)
  $.ajax
    type: 'POST'
    username: settings.get('user')
    password: settings.get('password')
    async: true
    url: settings.json_url()
    cache: false
    dataType: 'json'
    data: """
          {"jsonrpc": "2.0", "method": "#{options.method}", 
            "params": 
              #{JSON.stringify(options.params || '')}, 
            "id": #{Backbone.sync_id()}}"
          """
            
    error: (xhr, textStatus, errorThrown) ->
      if options.error
        options.error(xhr, textStatus, errorThrown)
      else
        console.error("#{options.method} - #{textStatus}")
    success: (response, status, xhr) ->
      if options.success
        options.success(response.result, status, xhr)
      else
        console.log("#{options.method} OK")
  
Backbone.playlist_sync = (method, playlist, options) =>
  options.default_success = options.success
  options.method = playlist.method()
  options.params = {"fields": playlist.fields}

  options.success = (result, status, xhr) =>
    old_titles = playlist.pluck('title')
    options.default_success(result.items, status, xhr)

    # changed == new position in playlist
    #            new titles in playlist
    #            or new first item in playlist
    if playlist.current != result.current
      playlist.current = result.current
      playlist.trigger('changed:playlist')

    new_titles = playlist.pluck('title')

    if _.difference(old_titles, new_titles).length > 0 || old_titles[0] != new_titles[0]
      playlist.trigger('changed:playlist')
    
    old_state = playlist.state
    
    playlist.state = switch true
      when result.paused  then 'paused' 
      when result.playing then 'playing'
      else 'stopped'
  
    playlist.trigger('changed:state') if playlist.state != old_state
  
  Backbone.xbmc_call(method, playlist, options)
  

Backbone.player_sync = (method, player, options) =>
  options.action ?= 'player_type'
  
  switch options.action
    when 'player_type'
      Backbone.player_type_sync(method, player, options)
    else 
      options.method = options.action
      options.success = () ->
      Backbone.xbmc_call(method, player, options)

Backbone.player_type_sync = (method, player, options) =>
  options.method = 'Player.GetActivePlayers'
  
  options.success = (result) ->    
    new_state = switch true 
      when result.audio then 'audio'
      when result.video then 'video'
      when result.picture then 'picture'
      else 'stopped'
    
    player.set({media: new_state})
    player.playlist.fetch()

  Backbone.xbmc_call(method, player, options)

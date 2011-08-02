Backbone.syncId = () ->
  @id = @id || 0
  @id++
  
Backbone.xbmcCall = (method, model, options) ->
  # console.log(options.method)
  $.ajax
    type: 'POST'
    username: settings.get('user')
    password: settings.get('password')
    async: true
    url: settings.jsonUrl()
    cache: false
    dataType: 'json'
    data: """
          {"jsonrpc": "2.0", "method": "#{options.method}", 
            "params": 
              #{JSON.stringify(options.params || '')}, 
            "id": #{Backbone.syncId()}}"
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
  
Backbone.playlistSync = (method, playlist, options) =>
  options.defaultSuccess = options.success
  options.method = playlist.method()
  options.params = {"fields": playlist.fields}

  options.success = (result, status, xhr) =>
    oldTitles = playlist.pluck('title')
    options.defaultSuccess(result.items, status, xhr)

    # changed == new position in playlist
    #            new titles in playlist
    #            or new first item in playlist
    if playlist.current != result.current
      playlist.current = result.current
      playlist.trigger('changed:playlist')

    newTitles = playlist.pluck('title')

    if _.difference(oldTitles, newTitles).length > 0 || oldTitles[0] != newTitles[0]
      playlist.trigger('changed:playlist')
    
    oldState = playlist.state
    
    playlist.state = switch true
      when result.paused  then 'paused' 
      when result.playing then 'playing'
      else 'stopped'
  
    playlist.trigger('changed:state') if playlist.state != oldState
  
  Backbone.xbmcCall(method, playlist, options)
  

Backbone.playerSync = (method, player, options) =>
  options.action ?= 'player_type'
  
  switch options.action
    when 'player_type'
      Backbone.playerTypeSync(method, player, options)
    else 
      options.method = options.action
      options.success = () ->
      Backbone.xbmcCall(method, player, options)

Backbone.playerTypeSync = (method, player, options) =>
  options.method = 'Player.GetActivePlayers'

  options.success = (result) ->    
    newState = switch true 
      when result.audio then 'audio'
      when result.video then 'video'
      when result.picture then 'picture'
      else 'stopped'
    
    player.set({state: newState})
    player.playlist.fetch()
    
  Backbone.xbmcCall(method, player, options)

Backbone.sync_id = () ->
  @id = @id || 0
  @id++
  
Backbone.xbmc_call = (method, model, options) ->
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
              #{JSON.stringify(options.params)}, 
            "id": #{Backbone.sync_id()}}"
          """
            
    error: (xhr, textStatus, errorThrown) ->
      options.error(xhr, textStatus, errorThrown)
    success: (response, status, xhr) ->
      options.success(response.result, status, xhr)
  
Backbone.playlist_sync = (method, playlist, options) ->
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
      playlist.trigger('changed')

    new_titles = playlist.pluck('title')

    if _.difference(old_titles, new_titles).length > 0 || old_titles[0] != new_titles[0]
      playlist.trigger('changed')

    playlist.state = switch true
      when result.paused  then 'paused' 
      when result.playing then 'playing'
      else 'stopped'
      
  $(self).stop true
  $(self).everyTime 1000, () ->
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

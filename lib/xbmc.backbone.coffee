Backbone.playlist_sync = (method, playlist, options) ->
  $.ajax
    type: 'POST'
    username: 'xbmc'
    password: 'xbmc'
    async: true
    url: 'http://localhost:8080/jsonrpc'
    cache: false
    dataType: 'json'
    data: """
          {"jsonrpc": "2.0", "method": "#{playlist.method()}", 
            "params": 
              {"fields": #{JSON.stringify(playlist.fields)}}, 
            "id": 1}"
          """
            
    error: (xhr, textStatus, errorThrown) ->
      options.error(xhr, textStatus, errorThrown)
    success: (response) ->
      options.success(response.result.items)
      playlist.current = response.result.current
      
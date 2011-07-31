class window.Settings extends Backbone.Model
  defaults: () ->
    user: 'xbmc'
    password: 'xbmc'
    host: 'http://localhost'
    port: '8080'
  url: () ->
    "#{this.get('host')}:#{this.get('port')}"
  json_url: () =>
    "#{this.url()}/jsonrpc"
  fetch: () ->
    #load from localStorage
  save: () ->
    #write to localStorage
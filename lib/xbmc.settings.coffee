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
    this.attributes = JSON.parse(localStorage.options) if localStorage.options
    this
  save: () ->
    localStorage.options = JSON.stringify(this.attributes)
    this

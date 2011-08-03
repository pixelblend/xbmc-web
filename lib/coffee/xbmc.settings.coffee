class window.Settings extends Backbone.Model
  defaults: () ->
    user: 'xbmc'
    password: 'xbmc'
    host: 'http://example.com'
    port: '8080'
  url: () ->
    "#{this.get('host')}:#{this.get('port')}"
  jsonUrl: () =>
    "#{this.url()}/jsonrpc"
  fetch: () ->
    this.attributes = JSON.parse(localStorage.options) if localStorage.options
    this
  save: () ->
    localStorage.options = JSON.stringify(this.attributes)
    this

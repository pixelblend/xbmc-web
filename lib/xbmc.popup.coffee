class window.Popup extends Backbone.View
  id: 'now_playing'
  tagName: 'div'
  initialize: () =>
    this.collection.bind('changed', this.render)
    this.template = _.template($("#now_playing").html())
  render: () =>
    canvas = $(this.el)
    now_playing = this.collection.now_playing()
    if now_playing
      canvas.html(this.template(now_playing.attributes)).appendTo('body#popup')
    else
      canvas.html this.template
        title: ''
        artist: ''
      
    canvas.appendTo('body#popup')
    this

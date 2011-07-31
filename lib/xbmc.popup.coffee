class window.Popup extends Backbone.View
  id: 'now_playing'
  tagName: 'h1'
  initialize: () =>
    this.collection.bind('changed', this.render);
  render: () =>
    now_playing = this.collection.now_playing()
    if now_playing
      title = now_playing.get('title')
      $(this.el).html(title)
      
    this

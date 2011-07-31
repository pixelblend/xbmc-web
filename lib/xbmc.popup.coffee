class window.Popup extends Backbone.View
  id: 'playing'
  el: 'h1'
  initialize: () =>
    this.collection.bind('changed', this.render);
  render: () =>
    title = this.collection.now_playing().get('title')
    console.log(title)
    $(this.el).html(title)
    this

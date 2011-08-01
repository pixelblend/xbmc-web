class window.Popup extends Backbone.View
  id: 'now-playing'
  tagName: 'div'
  events:
    'click #controls a': 'notify_playlist'
  initialize: () =>
    this.collection.bind('changed', this.render)
    this.template = _.template($("#now-playing").html())
  render: () =>
    canvas = $(this.el)
    now_playing = this.collection.now_playing()
    now_playing = new this.collection.model() if !now_playing

    canvas.html(this.template(now_playing.to_view())).appendTo('body#popup')
    
    this.animate_titles()
    
    this
  animate_titles: () =>
    maxWidth = $('#now-playing-text').width()

    $('#now-playing-text span').each () ->
      try
        offset = 5
        scrollTime = 3000
        holdTime = 1000

        $(this).everyTime 5, () ->
          if $(this).width() > maxWidth-offset
            scrollLength = '-'+(($(this).width()-maxWidth)+offset)
            $(this).animate({left: scrollLength}, scrollTime).animate({left: scrollLength}, holdTime)
              .animate({left:0}, scrollTime).animate({left:0}, holdTime)
      catch error
        console.error(error)
  notify_playlist: (event) ->
    event.preventDefault()
    clicked = $(event.target)
    # console.log('POP: '+clicked.attr('id'))
    this.collection.trigger('action:'+clicked.attr('id'))

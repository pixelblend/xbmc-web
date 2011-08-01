class window.Popup extends Backbone.View
  id: 'now-playing'
  tagName: 'div'
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
      $(this).stop(true).css('left',0)

      offset = 5
      scrollTime = 3000
      holdTime = 1000

      $(this).everyTime 5, () ->
        if $(this).width() > maxWidth-offset
          scrollLength = '-'+(($(this).width()-maxWidth)+offset)
          $(this).animate({left: scrollLength}, scrollTime).animate({left: scrollLength}, holdTime)
            .animate({left:0}, scrollTime).animate({left:0}, holdTime)
        else
          $(this).stop(true).css('left',0)
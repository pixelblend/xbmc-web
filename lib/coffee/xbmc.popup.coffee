class window.Popup extends Backbone.View
  id: 'now-playing'
  tagName: 'div'
  events:
    'click #controls a': 'notifyPlaylist'
  initialize: () =>
    this.musicTemplate = _.template($("#music-template").html())
    this.filmTemplate = _.template($("#film-template").html())
    this.tvTemplate = _.template($("#tv-template").html())
    this.undefinedTemplate = _.template($("#undefined-template").html())
    this.controlTemplate = _.template($("#controls-template").html())
    
    @canvas = $(this.el)
    $('<div />', id: 'controls').appendTo @canvas
    $('<div />', id: 'play-details').appendTo @canvas
    @canvas.appendTo('body#popup')
    
    if this.collection
      this.collection.bind('changed:playlist', this.renderPlaylist)
      this.collection.bind('changed:state', this.renderControls)
  render: () =>
    this.renderControls().renderPlaylist()
  renderControls: () =>
    if this.collection
      controlAttrs = 
        playPauseLabel: if this.collection.state == 'playing' then 'Pause' else 'Play'
      @canvas.find('#controls').html(this.controlTemplate(controlAttrs))
    else
      @canvas.find('#controls').html('')
    this
  renderPlaylist: () =>
    if this.collection && this.collection.length > 0
      nowPlaying = this.collection.nowPlaying()
      playingTemplate = this["#{nowPlaying.get('type')}Template"]
      @canvas.find('#play-details').html(playingTemplate(nowPlaying.attributes))

      this.animateTitles()
    else
      @canvas.find('#play-details').html('stopped')
    this
  animateTitles: () =>
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
  notifyPlaylist: (event) ->
    event.preventDefault()
    clicked = $(event.target)
    clickedId = clicked.attr('id')
    this.collection.trigger('action:'+clickedId)
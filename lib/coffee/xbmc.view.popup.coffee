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
    @canvas.append $('<div />', id: 'controls')
    @canvas.append $('<div />', id: 'play-details')
    @canvas.appendTo('body#popup')
    
    this.player = this.options.player
    
    if this.player
      this.player.bind('changed:playlist', this.refreshCollection)
    
    this.refreshCollection()
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
    viewWidth = $('#now-playing-text').width()
    nowPlayingPanels = $('#now-playing-text span')
    offset = 5
    animationLength = 3000
    
    #find the longest scrolling time required to keep everything readable
    maxScrollTime = _(nowPlayingPanels).chain()
                      .map (s) -> 
                        $(s).width() / viewWidth * 1000
                      .max().value()

    if maxScrollTime > animationLength
      # increase the animation length to keep animations in sync
      animationLength = maxScrollTime + 500

    nowPlayingPanels.each () ->
      try        
        self = $(this)
        self.everyTime 5, () ->
          totalWidth = self.width()
          if totalWidth > viewWidth - offset
            scrollLength = (totalWidth - viewWidth) + offset
            scrollTime = (totalWidth / viewWidth) * 1000
                        
            holdTime = animationLength - scrollTime
            scrollLength = '-'+scrollLength
            
            self.animate({left: scrollLength}, scrollTime, 'linear').animate({left: scrollLength}, holdTime)
              .fadeOut('slow').animate({left:0}, 0).fadeIn('fast')
      catch error
        console.error(error)
  refreshCollection: () =>
    if this.player
      this.collection = this.player.playlist
    
    if this.collection
      this.collection.bind('changed:playlist', this.renderPlaylist)
      this.collection.bind('changed:state', this.renderControls)
    this.render()
  notifyPlaylist: (event) ->
    event.preventDefault()
    clicked = $(event.target)
    clickedId = clicked.attr('id')
    this.collection.trigger('action:'+clickedId)
class window.Options extends Backbone.View
  id: 'options-form'
  tagName: 'div'
  model: Settings
  events:
    'submit form': 'submitForm'
  initialize: () =>
    this.template = _.template($("#options-form").html())
  render: () =>
    canvas = $(this.el)
    canvas.html(this.template(this.model)).appendTo('body#options')
    this
  submitForm: (event) ->
    form = $(this.el)
    event.preventDefault()
    
    newAttributes = {}
    keys = _.keys(this.model.attributes)
    
    _.each keys, (attr) =>
      newAttributes[attr] = form.find('input#'+attr).val()
      
    this.model.set(newAttributes)
    this.model.save()
    
    background = chrome.extension.connect name: 'background'
    background.postMessage()
    
    form.find('#flash').fadeOut('fast').fadeIn('slow')
    
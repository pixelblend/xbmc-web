class window.Options extends Backbone.View
  id: 'options-form'
  tagName: 'div'
  model: Settings
  events:
    'submit form': 'submit_form'
  initialize: () =>
    this.template = _.template($("#options-form").html())
  render: () =>
    canvas = $(this.el)
    canvas.html(this.template(this.model)).appendTo('body#options')
    this
  submit_form: (event) ->
    form = $(this.el)
    event.preventDefault()
    
    new_attributes = {}
    keys = _.keys(this.model.attributes)
    
    _.each keys, (attr) =>
      new_attributes[attr] = form.find('input#'+attr).val()
      
    this.model.set(new_attributes)
    this.model.save()
    
    background = chrome.extension.connect name: 'background'
    background.postMessage()
    
    form.find('#flash').fadeOut('fast').fadeIn('slow')
    
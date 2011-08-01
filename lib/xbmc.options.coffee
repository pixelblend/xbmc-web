class window.Options extends Backbone.View
  id: 'options-form'
  tagName: 'div'
  model: Settings
  initialize: () =>
    this.template = _.template($("#options-form").html())
  render: () =>
    canvas = $(this.el)
    canvas.html(this.template(this.model)).appendTo('body#options')
    
    canvas.find('form').submit (event) => 
      event.preventDefault()
      new_attributes = {}
      keys = _.keys(this.model.attributes)
      
      _.each keys, (attr) =>
        new_attributes[attr] = $('input#'+attr).val()
        
      this.model.set(new_attributes)
      this.model.save()
    this
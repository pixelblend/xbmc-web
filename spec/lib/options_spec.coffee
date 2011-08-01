describe 'Options', () ->
  beforeEach () ->
    loadFixtures('options.html')
    
    @settings = new Settings
      user: 'xbmc'
      password: 'obviouspass'
      host: 'localhost'
      port: 8080
      
    @options = new Options model: @settings
    @options.render()
    
    @canvas = $(@options.el)
    @form = @canvas.find('form')
  
  it "renders a form in a div", () ->
    expect(@form).toBeTruthy()
    expect(@options.tagName).toEqual('div')
    expect(@options.el.id).toEqual('options-form')

  it "fills form fields with settings model", () ->
    expect(@form.find('input#user').val()).toEqual('xbmc')
    expect(@form.find('input#password').val()).toEqual('obviouspass')
    expect(@form.find('input#host').val()).toEqual('localhost')
    expect(@form.find('input#port').val()).toEqual('8080')
    
  it "hides password in a password field", () ->
    expect(@form.find('input#password').attr('type')).toEqual('password')
  
  describe 'submitted form', () ->
    it "saves information to the model", () ->
      @form.find('input#password').val('pass123')
      @form.submit()
      
      @settings.fetch()
    
      expect(@settings.get('user')).toEqual('xbmc')
      expect(@settings.get('password')).toEqual('pass123')
      expect(@settings.get('host')).toEqual('localhost')
      expect(@settings.get('port')).toEqual('8080')
  
    it "displays flash message confirming save", () ->
      flash = @form.find('#flash')
      expect(flash.css('display') == 'none').toBeTruthy()
      
      @form.submit()
      expect(flash.css('display') == 'none').toBeFalsy()

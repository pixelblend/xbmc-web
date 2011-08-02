describe 'Settings', () ->
  beforeEach () ->
    @settings = new Settings
  
  it "has default values", () ->
    values = _.keys(@settings.attributes)
    expect(values).toEqual(['user', 'password', 'host', 'port'])
  
  it "produces the JSON-RPC URL", () ->
    expect(@settings.jsonUrl()).toEqual('http://example.com:8080/jsonrpc')
  
  describe 'localStorage', () ->
    beforeEach () ->
      @settings.set
        user: 'pixelblend'
        password: 'obviouspass'
        host: 'xbmc.localhost'
        port: 7171
        
    it "saves and fetches", () ->
      @settings.save()
      
      newSettings = new Settings
      newSettings.fetch()

      newValues   = _.values(newSettings.attributes)
      savedValues = _.values(@settings.attributes)
      
      expect(newValues).toEqual(savedValues)
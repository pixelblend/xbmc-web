describe 'Settings', () ->
  beforeEach () ->
    @settings = new Settings
  
  it "has default values", () ->
    values = _.keys(@settings.attributes)
    expect(values).toEqual(['user', 'password', 'host', 'port'])
  
  it "produces the JSON-RPC URL", () ->
    expect(@settings.json_url()).toEqual('http://localhost:8080/jsonrpc')
  
  describe 'localStorage', () ->
    beforeEach () ->
      @settings.set
        user: 'pixelblend'
        password: 'obviouspass'
        host: 'xbmc.localhost'
        port: 7171
        
    it "saves and fetches", () ->
      @settings.save()
      
      new_settings = new Settings
      new_settings.fetch()
      
      new_values   = _.values(new_settings.attributes)
      saved_values = _.values(@settings.attributes)
      
      expect(new_values).toEqual(saved_values)
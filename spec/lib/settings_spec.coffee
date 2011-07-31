describe 'Settings', () ->
  beforeEach () ->
    @settings = new Settings
  
  it "has default values", () ->
    values = _.keys(@settings.attributes)
    expect(values).toEqual(['user', 'password', 'host', 'port'])
  
  it "produces the JSON-RPC URL", () ->
    expect(@settings.json_url()).toEqual('http://localhost:8080/jsonrpc')
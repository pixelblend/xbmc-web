if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.model = {
    query: function(method, successCallback, params){
      if (typeof params == 'object') {
        jsonParams = JSON.stringify(params);
      } else {
        jsonParams = '{}';
      }

      $.ajax({
          type: 'POST'
        , username: xbmc.options.user()
        , password: xbmc.options.password()
        , async: true
        , url: xbmc.options.jsonUrl()
        , cache: false
        , dataType: 'json'
        , data: '{"jsonrpc": "2.0", "method": "'+method+'", "params": '+jsonParams+', "id": '+this.id()+'}'
        , error: function(xhr, textStatus, errorThrown){ 
            console.error("XHR Response: " + JSON.stringify(xhr));
          }
        , success: function(response){
            if (typeof successCallback == 'function'){
              successCallback(response.result);
            } else {
              return console.warn(JSON.stringify(response.result));
            }
          }
      });
    }
  , checkConnection: function(){
      this.query('JSONRPC.Version', function(result){
        if (typeof result.version != 'undefined'){
          return true;
        }
      });
    }
  , id: function(){
      this._id += 1;
      return this._id;
    }
  , _id: 0
};
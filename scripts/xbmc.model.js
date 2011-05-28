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
				, username: 'xbmc'
				,	password: 'xbmc'
				, async: true
				, url: 'http://xbmc.milo:8080/jsonrpc'
				, cache: false
				, dataType: 'json'
				, data: '{"jsonrpc": "2.0", "method": "'+method+'", "params": '+jsonParams+', "id": 1}'
				,	error: function(jqXHR, textStatus, errorThrown){ 
						// alert(textStatus+' - '+errorThrown); // turned off - too noisy
						return true;
					}
				, success: function(response){
						if (typeof successCallback == 'function'){
							successCallback(response.result);
						} else {
							return alert(JSON.stringify(response.result));
						}
					}
 			});
		}
	,	checkConnection: function(){
			this.query('JSONRPC.Version', function(result){
				alert(result.version);
			});
		}
};
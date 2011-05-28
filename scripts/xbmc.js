var Xbmc = {
		_connect: function(method, successCallback, params){
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
				,	error: function(jqXHR, textStatus, errorThrown){ alert(textStatus+' - '+errorThrown); }
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
			this._connect('JSONRPC.Version', function(result){
				$('<h1>XBMC Version '+result.version+'</h1>').appendTo('body');
			});
		}
	,	listArtists: function(){
		this._connect('AudioLibrary.GetArtists', function(result){
      $.each(result.artists, function(index,a) {
        $('<li>'+a.label+'</li>').appendTo('#artists');
      });
		}, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
	}
};

window.xbmc = Xbmc;
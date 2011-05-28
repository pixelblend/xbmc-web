var Xbmc = Backbone.Model.extend({
		_connect: function(method, successCallback, params){
			$.ajax({
					type: 'POST'
				, username: 'xbmc'
				,	password: 'xbmc'
				, async: true
				, url: 'http://xbmc.milo:8080/jsonrpc'
				, cache: false
				, dataType: 'json'
				, data: '{"jsonrpc": "2.0", "method": "'+method+'", "params": '+JSON.stringify(params)+', "id": 1}'
				,	error: function(jqXHR, textStatus, errorThrown){ alert(textStatus+' - '+errorThrown); }
				, success: function(response){
						if (successCallback === undefined){
							return response.result;
						} else {
							successCallback(response.result);
						}
					}
 			});
		}
	,	checkConnection: function(){
			return this._connect('JSONRPC.Version');
		}
	,	listArtists: function(){
		this._connect('AudioLibrary.GetArtists', function(result){
      $.each(result.artists, function(index,a) {
        $('<li>'+a.label+'</li>').appendTo('#artists');
      });
		}, { "start": 0, "sort": { "order": "descending", "method": "artist" } });
	}
});

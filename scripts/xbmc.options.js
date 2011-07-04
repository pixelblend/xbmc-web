if(typeof window.xbmc == 'undefined')
  window.xbmc = {};

xbmc.options = {
		attributes: ['user', 'password', 'host', 'port']
	,	user: function(newUser) {
			if(typeof newUser == 'string')
				localStorage.user = newUser;
				
			return localStorage.user;
		}
	,	password: function(newPassword) {
			if(typeof newPassword == 'string')
				localStorage.password = newPassword;
				
			return localStorage.password;
		}
	,	host: function(newHost) {
			if(typeof newHost == 'string')
				localStorage.host = newHost;
				
			return localStorage.host || 'http://localhost';
		}
	,	port: function(newPort) {
			if(typeof newPort == 'string')
				localStorage.port = newPort;

			return localStorage.port || '8080';
		}
	, jsonUrl: function() {
	  return  this.host()+':'+this.port()+'/jsonrpc'
	}
	,	buildForm: function() {
			var form = $('<form/>', {
					id: 'options'
			});
			
			$(this.attributes).each(function(key,attr) {
			  inputType = (attr == 'password' ? 'password' : 'text');
			  $('<label/>', {for: attr, text: attr}).appendTo(form);
				$('<input/>', {id: attr, type: inputType, value: xbmc.options[attr]()}).appendTo(form);
			});
			
			$('<button/>', {type: 'submit', text: 'Save'}).appendTo(form);
			
			form.appendTo('body');
			
			$("#userName").focus();
			
      form.submit(function (e) {
        e.preventDefault();
				  xbmc.options.saveForm();
      });
		}
	, saveForm: function() {
  	  $(this.attributes).each(function(key,attr) {
  	    newValue = $('#'+attr).val();
  	    xbmc.options[attr](newValue);
      });

			//restart polling
			xbmc.controller.pollForStatus();
			
      alert('saved!');
	}
};
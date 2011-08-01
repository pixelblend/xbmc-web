(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  window.AppController = (function() {
    __extends(AppController, Backbone.Router);
    function AppController() {
      this.background = __bind(this.background, this);
      AppController.__super__.constructor.apply(this, arguments);
    }
    AppController.prototype.routes = {
      '': 'index',
      'background': 'background',
      'options': 'options',
      'popup': 'popup'
    };
    AppController.prototype.initialize = function() {
      var location;
      location = $('body').attr('id');
      if (location) {
        return this.navigate(location, true);
      }
    };
    AppController.prototype.index = function() {
      return console.error('#index - Nothing to happen here yet');
    };
    AppController.prototype.background = function() {
      console.log('background');
      window.settings = new Settings;
      settings.fetch();
      window.playlist = new AudioPlaylist;
      return playlist.fetch();
    };
    AppController.prototype.options = function() {
      console.log('options');
      window.settings = new Settings;
      settings.fetch();
      window.options = new Options({
        model: settings
      });
      return options.render();
    };
    AppController.prototype.popup = function() {
      console.log('popup');
      window.popup = new Popup({
        collection: chrome.extension.getBackgroundPage().playlist
      });
      return popup.render();
    };
    return AppController;
  })();
  $(function() {
    return window.controller = new AppController;
  });
}).call(this);

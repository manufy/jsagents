// Generated by CoffeeScript 1.3.1
(function() {
  var Collection, Events, Model, View;

  Events = (function() {

    Events.name = 'Events';

    function Events() {}

    return Events;

  })();

  _.extend(Events.prototype, Backbone.Events);

  this.Events = Events;

  Model = (function() {

    Model.name = 'Model';

    function Model() {
      Backbone.Model.apply(this, arguments);
    }

    return Model;

  })();

  _.extend(Model.prototype, Backbone.Model.prototype);

  this.Model = Model;

  Collection = (function() {

    Collection.name = 'Collection';

    function Collection() {
      Backbone.Collection.apply(this, arguments);
    }

    return Collection;

  })();

  _.extend(Collection.prototype, Backbone.Collection.prototype);

  this.Collection = Collection;

  View = (function() {

    View.name = 'View';

    function View() {
      Backbone.View.apply(this, arguments);
    }

    return View;

  })();

  _.extend(View.prototype, Backbone.View.prototype);

  this.View = View;

}).call(this);

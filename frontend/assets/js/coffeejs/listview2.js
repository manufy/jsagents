// Generated by CoffeeScript 1.3.1
(function() {
  var Item2, List2, ListView2,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  jQuery(function() {});

  Item2 = (function(_super) {

    __extends(Item2, _super);

    Item2.name = 'Item2';

    function Item2() {
      return Item2.__super__.constructor.apply(this, arguments);
    }

    Item2.prototype.defaults = {
      part1: 'Hello',
      part2: 'Backbone'
    };

    return Item2;

  })(Backbone.Model);

  List2 = (function(_super) {

    __extends(List2, _super);

    List2.name = 'List2';

    function List2() {
      return List2.__super__.constructor.apply(this, arguments);
    }

    List2.prototype.model = Item2;

    return List2;

  })(Backbone.Collection);

  ListView2 = (function(_super) {

    __extends(ListView2, _super);

    ListView2.name = 'ListView2';

    function ListView2() {
      return ListView2.__super__.constructor.apply(this, arguments);
    }

    ListView2.prototype.el = $('#ulitemlistview2');

    ListView2.prototype.initialize = function() {
      _.bindAll(this);
      this.collection = new List2;
      this.collection.bind('add', this.appendItem);
      this.counter = 0;
      return this.render();
    };

    ListView2.prototype.render = function() {
      $(this.el).append('<button>Add List Item</button>');
      return $(this.el).append('<ul></ul>');
    };

    ListView2.prototype.addItem = function() {
      var item;
      this.counter++;
      item = new Item2;
      item.set({
        part2: this.counter
      });
      return this.collection.add(item);
    };

    ListView2.prototype.appendItem = function(item) {
      return $('#ulitemlistview2').append("<li>" + (item.get('part1')) + " " + (item.get('part2')) + " !</li>");
    };

    ListView2.prototype.events = {
      'click button': 'addItem'
    };

    return ListView2;

  })(Backbone.View);

}).call(this);
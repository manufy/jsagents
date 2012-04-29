// Generated by CoffeeScript 1.3.1
(function() {
  var EditVenueView, Venue, VenueCollection,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function() {});

  Venue = (function(_super) {

    __extends(Venue, _super);

    Venue.name = 'Venue';

    function Venue() {
      return Venue.__super__.constructor.apply(this, arguments);
    }

    Venue.prototype.getName = function() {
      return this.get('name');
    };

    Venue.prototype.getAddress = function() {
      return [this.get('address'), this.get('city'), this.get('state')].join(", ");
    };

    Venue.prototype.getImageUrl = function() {
      return this.get('photo_url');
    };

    Venue.prototype.getLatitude = function() {
      return this.get('geolat');
    };

    Venue.prototype.getLongitude = function() {
      return this.get('geolong');
    };

    Venue.prototype.getMapUrl = function(width, height) {
      width || (width = 300);
      height || (height = 220);
      return "http://maps.google.com/maps/api/staticmap?center=" + (this.getLatitude()) + "," + (this.getLongitude());
    };

    return Venue;

  })(Backbone.Model);

  VenueCollection = (function(_super) {

    __extends(VenueCollection, _super);

    VenueCollection.name = 'VenueCollection';

    VenueCollection.prototype.model = Venue;

    function VenueCollection() {
      this.refresh($FOURSQUARE_JSON);
    }

    return VenueCollection;

  })(Backbone.Collection);

  EditVenueView = (function(_super) {

    __extends(EditVenueView, _super);

    EditVenueView.name = 'EditVenueView';

    function EditVenueView() {
      this.render = __bind(this.render, this);
      EditVenueView.__super__.constructor.apply(this, arguments);
      this.el = $('#googeexample');
      this.template = _.template('  <form action="#venue-<%= venue.cid %>-update" method="post">\n\n    <div data-role="fieldcontain">\n      <label>Name</label>\n      <input type="text" value="<%= venue.getName() %>" name="name" />\n    </div>\n\n    <div data-role="fieldcontain">\n      <label>Address</label>\n      <input type="text" value="<%= venue.get(\'address\') %>" name="address" />\n    </div>\n\n    <div data-role="fieldcontain">\n      <label>City</label>\n      <input type="text" value="<%= venue.get(\'city\') %>" name="city" />\n    </div>\n\n    <div data-role="fieldcontain">\n      <label>State</label>\n      <input type="text" value="<%= venue.get(\'state\') %>" name="state" />\n    </div>\n\n    <button type="submit" data-role="button">Save</button>\n  </form>');
      this.model.bind('change', this.render);
      this.render();
    }

    EditVenueView.prototype.events = {
      "submit form": "onSubmit"
    };

    EditVenueView.prototype.onSubmit = function(e) {
      this.model.set({
        name: this.$("input[name='name']").val(),
        address: this.$("input[name='address']").val(),
        city: this.$("input[name='city']").val(),
        state: this.$("input[name='state']").val()
      });
      this.model.trigger('change');
      app.goBack();
      e.preventDefault();
      return e.stopPropagation();
    };

    EditVenueView.prototype.render = function() {
      this.el.find('h1').text("Editing " + (this.model.getName()));
      this.el.find('.ui-content').html(this.template({
        venue: this.model
      }));
      app.reapplyStyles(this.el);
      return this.delegateEvents();
    };

    return EditVenueView;

  })(Backbone.View);

}).call(this);

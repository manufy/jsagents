class Events

_.extend(Events::, Backbone.Events)

this.Events = Events


class Model
  constructor: ->
    Backbone.Model.apply(this, arguments)
    
_.extend(Model::, Backbone.Model.prototype)

this.Model = Model


class Collection
  constructor: ->
    Backbone.Collection.apply(this, arguments)

_.extend(Collection::, Backbone.Collection.prototype)

this.Collection = Collection


class View
  constructor: ->
    Backbone.View.apply(this, arguments)

_.extend(View::, Backbone.View.prototype)

this.View = View
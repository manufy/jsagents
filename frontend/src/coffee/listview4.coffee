jQuery ->
  
class Item4 extends Backbone.Model
  
  defaults:
    part1: 'Hello'
    part2: 'Backbone'
    
class List4 extends Backbone.Collection
    
    model: Item4

class ItemView4 extends Backbone.View
  
  tagName: 'li'
  initialize: ->
    _.bindAll @    
    @model.bind 'change', @render
    @model.bind 'remove', @unrender
    
  render: ->
    $(@el).html  """
        <span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>
        <span class="swap">swap</span>
        <span class="delete">delete</span>
      """
    @
  
   unrender: =>
      $(@el).remove()
     
   swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'
        
   remove: -> @model.destroy()
   
   events:
      'click .swap': 'swap'
      'click .delete': 'remove'
   
class ListView4 extends Backbone.View
  
  el: $ '#ulitemlistview2'
  
  initialize:  ->
    _.bindAll @
    @collection = new List4
    @collection.bind 'add', @appendItem
    @counter = 0
    @render()
   
  render: ->
    $(@el).append('<button>Add List Item</button>')
    $(@el).append('<ul></ul>')
    
  addItem: ->
    @counter++
    item = new Item4
    item.set part2:  "<b>#{item.get 'part2'} #{@counter}</b>"
    @collection.add item
    
   appendItem: (item) ->
     itemview = new ItemView4 model: item
     $(@el).append itemview.render().el
     
    events: 'click button': 'addItem'
    
#Backbone.sync = (method, model, success, error) -> 
#  success()
    
listview4 = new ListView4

jQuery ->
  
class Item3 extends Backbone.Model
  
  defaults:
    part1: 'Hello'
    part2: 'Backbone'
    
class List3 extends Backbone.Collection
    
    model: Item3
    

class ItemView3 extends Backbone.View
  
  tagName: 'li'
  initialize: ->
    _.bindAll @
    
  render: ->
    $(@el).html  "<span>#{@model.get 'part1'} #{@model.get 'part2'}!</span>"
    
    @
   
class ListView3 extends Backbone.View
  
  el: $ 'body'
  
  initialize:  ->
    _.bindAll @
    @collection = new List3
    @collection.bind 'add', @appendItem
    @counter = 0
    @render()
   
  render: ->
    $(@el).append('<button>Add List Item</button>')
    $(@el).append('<ul></ul>')
    
  addItem: ->
    @counter++
    item = new Item3
    item.set part2:  "#{item.get 'part2'} #{@counter}"
    @collection.add item
    
   appendItem: (item) ->
     itemview = new ItemView3 model: item
     $('ul').append itemview.render().el
     
    events: 'click button': 'addItem'
    
    
#listview3 = new ListView3

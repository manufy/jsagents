jQuery ->
  
class Item2 extends Backbone.Model
  
  defaults:
    part1: 'Hello'
    part2: 'Backbone'
    
class List2 extends Backbone.Collection
    
    model: Item2

class ListView2 extends Backbone.View
  
  el: $ '#ulitemlistview2'
  
  initialize:  ->
    _.bindAll @
    @collection = new List2
    @collection.bind 'add', @appendItem
    @counter = 0
    @render()
   
  render: ->
    $(@el).append('<button>Add List Item</button>')
    $(@el).append('<ul></ul>')
    
  addItem: ->
    @counter++
    item = new Item2
    item.set part2: @counter # "#{item.get 'part2'} #{@counter}"
    @collection.add item
    
   appendItem: (item) ->
     $('#ulitemlistview2').append("<li>#{item.get 'part1'} #{item.get 'part2'} !</li>")
  
    events: 'click button': 'addItem'
    
#listview2 = new ListView2

jQuery ->
  
class ListView1 extends Backbone.View
  
    el: $ 'ulitemlistview1'
  
  initialize:  ->  
    _.bindAll @
    @counter = 0
    @render()
       
  render: ->
    $(@el).append '<button>Add Liscdst Item</button>'
    $(@el).append '<ul></ul>'
    
  addItem: ->
      @counter++
      $('#ulitemlistview1').append "<li>Hello, Backbone #{@counter}!</li>"
      
  events: 'click button': 'addItem'
    
#listview1 = new ListView1
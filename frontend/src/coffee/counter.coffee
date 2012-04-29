jQuery ->
                    
class Counter extends Backbone.Model

    defaults:
        count: 0

class CounterView extends Backbone.View

    initialize: ->
        @counter = new Counter()
        @render()

    el: $('#counter')

    events:
        'click button#inc-count' : 'inc'
        'click button#dec-count' : 'dec'

    render: ->  
        $(@el).find("#count").html "The count is " \
                + @counter.get("count")
        @
        
    inc: -> 
        ct = @counter.get("count")
        @counter.set(count: ct+1)
        @render()
        
    dec: -> 
        ct = @counter.get("count")
        @counter.set(count: ct-1)
        @render()    

counterview = new CounterView
    

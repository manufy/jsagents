#
# Agents Interfacing with MongoDB, By Manuel Fernández Yáñez 2012
#

jQuery ->
  
# In Memory and DB Agent representation Models
  
class Agent extends Backbone.Model
  
  defaults:
    name: 'manolo'
    content: 'TestContent'
    
class MongoBDAgent extends Backbone.Model
  
  idAttribute: '_id'
  
  defaults:
    name: 'defaultmongodbagentname'
    content: 'defaultmongodbagentcontent'
 
   
  url: 'http://db.local/jsagentsdb/agents/' 
 

  name: ->
    @get ('name')
   
  content: ->
    @get ('content')

# COLLECTIONS
    
class AgentsList extends Backbone.Collection
    
    model: Agent

class MongoDBAgents extends Backbone.Collection
  
    url: 'http://db.local/jsagentsdb/agents'
    model: MongoBDAgent
    
# MODEL VIEWS

class ItemViewAgent extends Backbone.View
  
  tagName: 'li'
  
  initialize: ->
    _.bindAll @
    @model.bind 'change',  @render   
    @model.bind 'remove',  @unrender
    console.log("itemviewagent initialize")
    
  # RENDER METHODS
    
  render: ->
    $(@el).html  """
        <span>id:#{@model.id} id_:#{@model.get '_id'} ok:#{@model.get 'ok'} name:#{@model.get 'name'} content:#{@model.get 'content'}!</span>
        <span class="swapagent"> SWAP </span>
        <span class="deleteagent"> DEL </span>
      """  
    console.log("render model")
    @
    
   unrender: =>
      $(@el).remove()
      console.log("unrender model")
      
   # UI ACTIONS
   
   add: =>
     console.log('add')
     
   swap: ->
      @model.set
        content: @model.get 'name'
        name:    @model.get 'content'
        
   remove: -> @model.destroy()
   
   # EVENTS
   
   events:
      'click .swapagent': 'swap'
      'click .deleteagent': 'remove' 
 
# MAIN VIEW 
  
class AgentsView extends Backbone.View
    
  el: $ '#agents'
  li: $ '#agentslist'
  
  template: """
    <button id='buttonaddagent'>Add Memory Model Agent</button>
    <button id='buttonremoveagents'>Reset Memory Agents</button>
    <button id='buttonviewagents'>VIEW Agents Memory Model</button>
    <button id='buttonmodifyagents'>MODIFY Agents Memory Model</button>
    <button id='buttonsaveagents'>SAVE DB Agents</button>
    <button id='buttonloadagents'>LOAD DB Agents</button>
    <ul></ul>
  """

  initialize:  ->  
    _.bindAll @
    
    @collection = new MongoDBAgents
    console.log ('Bootsrapping @collection.reset at ttp://db.local/jsagentsdb/agents')
    @collection.bind 'add', @appendItem
    @collection.bind("reset", @render)
    @counter = 0
    @render()    
    
  # RENDER METHODS   
       
  render: =>
    $(@el).html  @template
    for agent in @collection.models
       @appendItem(agent)
      
  appendItem: (item) ->
     itemview = new ItemViewAgent model: item
     $(@el).append itemview.render().el 
      
  # UI ACTIONS  
    
  addItem: ->
      @counter++
      @size = @collection.size()
      item = new Agent
      item.set name: "jswebagent"
      item.set ok:1
      item.set content: "Hello, Agent #{@counter} #{@size}!"
      @collection.add item
         
   removeAgents: ->
     @collection.reset()
     @counter = @counter + 10
     @render()
  
   modifyAgents: ->    
     for agent in @collection.models
       agent.set content: "MODIFIED"
     @render()
       
   loadAgents: ->
     @collection.fetch()
     console.log "Agents fetched " + @collection.size();
     @render()

   saveAgents: ->
     for agent in @collection.models
       agent.save()
       
   # LOG
       
   dumpAgents: ->
    console.log('---------------------- Agents ----------------------')
    console.log "Agents: " + @collection.size();
    for agent in @collection.models
       console.log "#{agent.get '_id'} #{agent.get 'name'} #{agent.get 'content'}"
       
   # MAIN VIEW EVENTS  
    
   events:
          'click #buttonaddagent':     'addItem'
          'click #buttonremoveagents': 'removeAgents'
          'click #buttonmodifyagents': 'modifyAgents'
          'click #buttonsaveagents':   'saveAgents'
          'click #buttonloadagents':   'loadAgents'
          'click #buttonviewagents':   'dumpAgents'
          
# INIT VIEW ON LOAD        
 
root = exports ? this
root.InitCoffeeScriptAgentView = ->
   console.log('View Start')
   agentsview = new AgentsView 


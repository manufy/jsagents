#
# Agents Interface, By Manuel Fernández Yáñez 2012
#

jQuery ->
  
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

    
class AgentsList extends Backbone.Collection
    
    model: Agent

class MongoDBAgents extends Backbone.Collection
  
    url: 'http://db.local/jsagentsdb/agents'
    model: MongoBDAgent
    
   

class ItemViewAgent extends Backbone.View
  
  tagName: 'li'
  
  initialize: ->
    _.bindAll @
    @model.bind 'change',  @render   
    @model.bind 'remove',  @unrender
    console.log("itemviewagent initialize")
    
  render: ->
    $(@el).html  """
        <span>id1:#{@model.id} id2:#{@model.get '_id'} ok:#{@model.get 'ok'} name:#{@model.get 'name'} content:#{@model.get 'content'}!</span>
        <span class="swapagent"> SWAP </span>
        <span class="deleteagent"> DEL </span>
      """  
    console.log("render model")
    @
    
   unrender: =>
      $(@el).remove()
      console.log("unrender model")
     
   swap: ->
      @model.set
        content: @model.get 'name'
        name:    @model.get 'content'
        
   remove: -> @model.destroy()
   
   events:
      'click .swapagent': 'swap'
      'click .deleteagent': 'remove' 
  
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
    @counter = 0
    @render()    
       
  render: =>
    $(@el).html  @template
    for agent in @collection.models
       @appendItem(agent)
   
  addItem: ->
      @counter++
      @size = @collection.size()
      item = new Agent
      item.set name: "jswebagent"
      item.set ok:1
      item.set content: "Hello, Agent #{@counter} #{@size}!"
      @collection.add item
      
  appendItem: (item) ->
     itemview = new ItemViewAgent model: item
     $(@el).append itemview.render().el 
    
  removeAgents: =>
     @collection.reset()
     @counter = @counter + 10
     @render()
  
   modifyAgents: =>    
     for agent in @collection.models
       agent.set content: "MODIFIED"
       #alert(agent.get 'content')
       
   loadAgents: =>
     @collection.fetch()
     console.log "Agents fetched " + @collection.size();
     @render()
     #@dumpAgents()
 
   saveAgents: =>
     for agent in @collection.models
       agent.save()
       
   dumpAgents: =>
    console.log('---------------------- Agents ----------------------')
    console.log "Agents: " + @collection.size();
    for agent in @collection.models
       console.log "#{agent.get '_id'} #{agent.get 'name'} #{agent.get 'content'}"
    
  events:
          'click #buttonaddagent':     'addItem'
          'click #buttonremoveagents': 'removeAgents'
          'click #buttonmodifyagents': 'modifyAgents'
          'click #buttonsaveagents':   'saveAgents'
          'click #buttonloadagents':   'loadAgents'
          'click #buttonviewagents':   'dumpAgents'
          
class AgentsController extends Backbone.Router
  
    router:
      
       "" : "index" 
       
   index: ->
     agents = new MongoDBAgents
     agents.fetch()
     board = new AgentsView(model: lanes)
     
agentsviews = new AgentsView
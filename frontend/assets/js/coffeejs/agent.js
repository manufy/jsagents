// Generated by CoffeeScript 1.3.1
(function() {
  var Agent, AgentsList, AgentsView, ItemViewAgent, MongoBDAgent, MongoDBAgents, root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  jQuery(function() {});

  Agent = (function(_super) {

    __extends(Agent, _super);

    Agent.name = 'Agent';

    function Agent() {
      return Agent.__super__.constructor.apply(this, arguments);
    }

    Agent.prototype.defaults = {
      name: 'manolo',
      content: 'TestContent'
    };

    return Agent;

  })(Backbone.Model);

  MongoBDAgent = (function(_super) {

    __extends(MongoBDAgent, _super);

    MongoBDAgent.name = 'MongoBDAgent';

    function MongoBDAgent() {
      return MongoBDAgent.__super__.constructor.apply(this, arguments);
    }

    MongoBDAgent.prototype.idAttribute = '_id';

    MongoBDAgent.prototype.defaults = {
      name: 'defaultmongodbagentname',
      content: 'defaultmongodbagentcontent'
    };

    MongoBDAgent.prototype.url = 'http://db.local/jsagentsdb/agents/';

    MongoBDAgent.prototype.name = function() {
      return this.get('name');
    };

    MongoBDAgent.prototype.content = function() {
      return this.get('content');
    };

    return MongoBDAgent;

  })(Backbone.Model);

  AgentsList = (function(_super) {

    __extends(AgentsList, _super);

    AgentsList.name = 'AgentsList';

    function AgentsList() {
      return AgentsList.__super__.constructor.apply(this, arguments);
    }

    AgentsList.prototype.model = Agent;

    return AgentsList;

  })(Backbone.Collection);

  MongoDBAgents = (function(_super) {

    __extends(MongoDBAgents, _super);

    MongoDBAgents.name = 'MongoDBAgents';

    function MongoDBAgents() {
      return MongoDBAgents.__super__.constructor.apply(this, arguments);
    }

    MongoDBAgents.prototype.url = 'http://db.local/jsagentsdb/agents';

    MongoDBAgents.prototype.model = MongoBDAgent;

    return MongoDBAgents;

  })(Backbone.Collection);

  ItemViewAgent = (function(_super) {

    __extends(ItemViewAgent, _super);

    ItemViewAgent.name = 'ItemViewAgent';

    function ItemViewAgent() {
      this.add = __bind(this.add, this);

      this.unrender = __bind(this.unrender, this);
      return ItemViewAgent.__super__.constructor.apply(this, arguments);
    }

    ItemViewAgent.prototype.tagName = 'li';

    ItemViewAgent.prototype.initialize = function() {
      _.bindAll(this);
      this.model.bind('change', this.render);
      this.model.bind('remove', this.unrender);
      return console.log("itemviewagent initialize");
    };

    ItemViewAgent.prototype.render = function() {
      $(this.el).html("<span>id:" + this.model.id + " id_:" + (this.model.get('_id')) + " ok:" + (this.model.get('ok')) + " name:" + (this.model.get('name')) + " content:" + (this.model.get('content')) + "!</span>\n<span class=\"swapagent\"> SWAP </span>\n<span class=\"deleteagent\"> DEL </span>");
      console.log("render model");
      return this;
    };

    ItemViewAgent.prototype.unrender = function() {
      $(this.el).remove();
      return console.log("unrender model");
    };

    ItemViewAgent.prototype.add = function() {
      return console.log('add');
    };

    ItemViewAgent.prototype.swap = function() {
      return this.model.set({
        content: this.model.get('name'),
        name: this.model.get('content')
      });
    };

    ItemViewAgent.prototype.remove = function() {
      return this.model.destroy();
    };

    ItemViewAgent.prototype.events = {
      'click .swapagent': 'swap',
      'click .deleteagent': 'remove'
    };

    return ItemViewAgent;

  })(Backbone.View);

  AgentsView = (function(_super) {

    __extends(AgentsView, _super);

    AgentsView.name = 'AgentsView';

    function AgentsView() {
      this.render = __bind(this.render, this);
      return AgentsView.__super__.constructor.apply(this, arguments);
    }

    AgentsView.prototype.el = $('#agents');

    AgentsView.prototype.li = $('#agentslist');

    AgentsView.prototype.template = "<button id='buttonaddagent'>Add Memory Model Agent</button>\n<button id='buttonremoveagents'>Reset Memory Agents</button>\n<button id='buttonviewagents'>VIEW Agents Memory Model</button>\n<button id='buttonmodifyagents'>MODIFY Agents Memory Model</button>\n<button id='buttonsaveagents'>SAVE DB Agents</button>\n<button id='buttonloadagents'>LOAD DB Agents</button>\n<ul></ul>";

    AgentsView.prototype.initialize = function() {
      _.bindAll(this);
      this.collection = new MongoDBAgents;
      console.log('Bootsrapping @collection.reset at ttp://db.local/jsagentsdb/agents');
      this.collection.bind('add', this.appendItem);
      this.collection.bind("reset", this.render);
      this.counter = 0;
      return this.render();
    };

    AgentsView.prototype.render = function() {
      var agent, _i, _len, _ref, _results;
      $(this.el).html(this.template);
      _ref = this.collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        agent = _ref[_i];
        _results.push(this.appendItem(agent));
      }
      return _results;
    };

    AgentsView.prototype.appendItem = function(item) {
      var itemview;
      itemview = new ItemViewAgent({
        model: item
      });
      return $(this.el).append(itemview.render().el);
    };

    AgentsView.prototype.addItem = function() {
      var item;
      this.counter++;
      this.size = this.collection.size();
      item = new Agent;
      item.set({
        name: "jswebagent"
      });
      item.set({
        ok: 1
      });
      item.set({
        content: "Hello, Agent " + this.counter + " " + this.size + "!"
      });
      return this.collection.add(item);
    };

    AgentsView.prototype.removeAgents = function() {
      this.collection.reset();
      this.counter = this.counter + 10;
      return this.render();
    };

    AgentsView.prototype.modifyAgents = function() {
      var agent, _i, _len, _ref;
      _ref = this.collection.models;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        agent = _ref[_i];
        agent.set({
          content: "MODIFIED"
        });
      }
      return this.render();
    };

    AgentsView.prototype.loadAgents = function() {
      this.collection.fetch();
      console.log("Agents fetched " + this.collection.size());
      return this.render();
    };

    AgentsView.prototype.saveAgents = function() {
      var agent, _i, _len, _ref, _results;
      _ref = this.collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        agent = _ref[_i];
        _results.push(agent.save());
      }
      return _results;
    };

    AgentsView.prototype.dumpAgents = function() {
      var agent, _i, _len, _ref, _results;
      console.log('---------------------- Agents ----------------------');
      console.log("Agents: " + this.collection.size());
      _ref = this.collection.models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        agent = _ref[_i];
        _results.push(console.log("" + (agent.get('_id')) + " " + (agent.get('name')) + " " + (agent.get('content'))));
      }
      return _results;
    };

    AgentsView.prototype.events = {
      'click #buttonaddagent': 'addItem',
      'click #buttonremoveagents': 'removeAgents',
      'click #buttonmodifyagents': 'modifyAgents',
      'click #buttonsaveagents': 'saveAgents',
      'click #buttonloadagents': 'loadAgents',
      'click #buttonviewagents': 'dumpAgents'
    };

    return AgentsView;

  })(Backbone.View);

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.InitCoffeeScriptAgentView = function() {
    var agentsview;
    console.log('View Start');
    return agentsview = new AgentsView;
  };

}).call(this);

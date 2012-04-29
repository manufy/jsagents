jQuery ->
  
class Venue extends Backbone.Model
  getName: ->
    @get('name')

  getAddress: ->
    [@get('address'), @get('city'), @get('state')].join ", "

  getImageUrl: ->
    @get('photo_url')

  getLatitude: ->
    @get('geolat')

  getLongitude: ->
    @get('geolong')

  getMapUrl: (width, height) ->
    width ||= 300
    height ||= 220

    "http://maps.google.com/maps/api/staticmap?center=#{@getLatitude()},#{@getLongitude()}"


class VenueCollection extends Backbone.Collection
  model : Venue

  constructor: ->
    @refresh($FOURSQUARE_JSON)
    
class EditVenueView extends Backbone.View
  constructor: ->
    super

    # Get the active page from jquery mobile. We need to keep track of what this
    # dom element is so that we can refresh the page when the page is no longer active.
    @el = $('#googeexample')

    @template = _.template('''
    <form action="#venue-<%= venue.cid %>-update" method="post">

      <div data-role="fieldcontain">
        <label>Name</label>
        <input type="text" value="<%= venue.getName() %>" name="name" />
      </div>
  
      <div data-role="fieldcontain">
        <label>Address</label>
        <input type="text" value="<%= venue.get('address') %>" name="address" />
      </div>
  
      <div data-role="fieldcontain">
        <label>City</label>
        <input type="text" value="<%= venue.get('city') %>" name="city" />
      </div>
  
      <div data-role="fieldcontain">
        <label>State</label>
        <input type="text" value="<%= venue.get('state') %>" name="state" />
      </div>
  
      <button type="submit" data-role="button">Save</button>
    </form>
    ''')

    # Watch for changes to the model and redraw the view
    @model.bind 'change', @render

    # Draw the view
    @render()

  events : {
    "submit form" : "onSubmit"
  }

  onSubmit: (e) ->
    @model.set {
      name : @$("input[name='name']").val(),
      address : @$("input[name='address']").val(),
      city : @$("input[name='city']").val(),
      state : @$("input[name='state']").val()
    }

    @model.trigger('change')

    app.goBack()

    e.preventDefault()
    e.stopPropagation()

  render: =>
    # Set the name of the page
    @el.find('h1').text("Editing #{@model.getName()}")

    # Render the content
    @el.find('.ui-content').html(@template({venue : @model}))

    # A hacky way of reapplying the jquery mobile styles
    app.reapplyStyles(@el)

    # Delegate from the events hash
    @delegateEvents()
    
#editvenueview = new EditVenueView
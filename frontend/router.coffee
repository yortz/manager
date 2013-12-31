frontend.navigate = (fragment, options) ->
  options = _.extend {trigger: true}, options
  Backbone.history.navigate(fragment, options)

class frontend.Router extends Backbone.Router
  initialize: (options) ->
    @$el = options.$el
    for [action, route] in _(options.routes).pairs().reverse()
      @route route, action

  render: (viewKlass, options = {}) ->
    @$el.empty().append (new viewKlass(options)).render().el

  dashboard: ->
    @render frontend.views.Companies, {collection: new frontend.collections.Companies()}

  companies: ->
    @render frontend.views.Companies, {collection: new frontend.collections.Companies()}

  company: (id) ->
    @company = new frontend.models.Company(id: id)
    @companyView = frontend.views.Company(model: @company)

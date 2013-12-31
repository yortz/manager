frontend.views.Companies = Backbone.View.extend
  tagName: "ul"
  className: "companies"
  initialize: (options) ->
    @template = Handlebars.compile(options.template or "<h2>Here is a list of Companies</h2>")
    @collection.fetch()
    @listenTo @collection, "add", @addOne

  render: ->
    @$el.html @template()
    @addAll()
    this

  addAll: ->
    @collection.each @addOne, this

  addOne: (model) ->
    view = new frontend.views.Company(model: model)
    view.render()
    @$el.append view.el
    model.on "remove", view.remove, view


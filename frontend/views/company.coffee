frontend.views.Company = Backbone.View.extend
  tagName: "li"

  initialize: (options) ->
    @template = Handlebars.compile(options.template or "<div class='name'>{{ company.name }}</div>")
    @listenTo @model, "change", @render
    @listenTo @model, "destroy", @remove

  render: ->
    @$el.html @template(company: @model.toJSON())
    this

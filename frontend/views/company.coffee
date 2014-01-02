frontend.views.Company = Backbone.View.extend
  tagName: "li"
  className: "list-group-item"

  initialize: (options) ->
    @template = Handlebars.compile(options.template or "<div class='name'><a href=\"/#company/{{ company.id }}\" >{{ company.name }}</a></div>")
    @listenTo @model, "change", @render
    @listenTo @model, "destroy", @remove

  render: ->
    @$el.html @template(company: @model.toJSON())
    this

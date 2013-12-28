frontend.collections.Companies = Backbone.Collection.extend

  model: frontend.models.Company
  url: "/api/v1/companies"

  parse: (res) ->
    companies = res.response.companies

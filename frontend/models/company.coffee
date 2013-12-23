frontend.models.Company = Backbone.Model.extend

  defaults:
    name: ""
    address: ""
    city: ""
    country: ""
    email: ""
    phone: ""

  #validation:
    #name:
      #required: true
    #address:
      #required: true

  validate: (attrs) ->
    if !attrs.name
      "name can't be blank"
    else if !attrs.address
      "address can't be blank"
    else if !attrs.city
      "city can't be blank"
    else if !attrs.country
      "country can't be blank"
    else if !attrs.email
      "email can't be blank"
    else if !attrs.phone
      "phone can't be blank"
    #"name can't be blank" if (!attrs.name)
    #"address can't be blank" if (!attrs.address)
    #"name can't be blank"  unless attrs.name
    #"address can't be blank"  unless attrs.address
    #"city can't be blank"  unless attrs.name
    #"country can't be blank"  unless attrs.name

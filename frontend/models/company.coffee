frontend.models.Company = Backbone.Model.extend

  defaults:
    name: ""
    address: ""
    city: ""
    country: ""
    email: ""
    phone: ""

  validation:
    name:
      required: true
      message: "name can't be blank"
    address:
      required: true
      message: "address can't be blank"
    city:
      required: true
      message: "city can't be blank"
    country:
      required: true
      message: "country can't be blank"
    email:
      required: true
      message: "email can't be blank"
    phone:
      required: true
      message: "phone can't be blank"



  #validate: (attrs) ->
    #if !attrs.name
      #"name can't be blank"
    #else if !attrs.address
      #"address can't be blank"
    #else if !attrs.city
      #"city can't be blank"
    #else if !attrs.country
      #"country can't be blank"
    #else if !attrs.email
      #"email can't be blank"
    #else if !attrs.phone
      #"phone can't be blank"
    ##"name can't be blank" if (!attrs.name)
    ##"address can't be blank" if (!attrs.address)
    ##"name can't be blank"  unless attrs.name
    ##"address can't be blank"  unless attrs.address
    ##"city can't be blank"  unless attrs.name
    ##"country can't be blank"  unless attrs.name

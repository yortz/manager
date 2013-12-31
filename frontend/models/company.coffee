frontend.models.Company = Backbone.Model.extend

  defaults:
    id: null
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

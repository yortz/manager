beforeEach ->
  @fixtures = _.extend(@fixtures or {},
    Companies:
      valid:
        status: "OK"
        version: "1.0"
        response:
          companies: [
            id: 1
            name: "Company 1"
            address: "M Street 56th NW"
            city: "Washington D.C."
            country: "USA"
            email: "email@domain.com"
            phone: 123456
          ,
            id: 2
            name: "Company 2"
            address: "U Street 34 NW"
            city: "Washington D.C."
            country: "USA"
            email: "email@mymail.com"
            phone: 12345667
          ,
            id: 3
            name: "Company 3"
            address: "M street 45"
            city: "Washington D.C."
            country: "USA"
            email: "email@domain.com"
            phone: 123456
          ]
  )
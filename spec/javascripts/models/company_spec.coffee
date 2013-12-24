describe "Company model", ->
  beforeEach ->
    @company = new frontend.models.Company(
      name: "My Company"
      address: "M Street 56th NW"
      city: "Washington D.C."
      country: "USA"
      email: "email@domain.com"
      phone: 123456
    )
    collection = url: "/api/v1/company"
    @company.collection = collection

  describe "when instantiated", ->
    it "should exhibit attributes", ->
      expect(@company.get("name")).toEqual "My Company"
      expect(@company.get("address")).toEqual "M Street 56th NW"
      expect(@company.get("city")).toEqual "Washington D.C."
      expect(@company.get("country")).toEqual "USA"
      expect(@company.get("email")).toEqual "email@domain.com"
      expect(@company.get("phone")).toEqual 123456

  describe "urls", ->
    describe "when no id is set", ->
      it "should return the company URL", ->
        expect(@company.url()).toEqual "/api/v1/company"


    describe "when id is set", ->
      it "should return the company URL and id", ->
        @company.id = 1
        expect(@company.url()).toEqual "/api/v1/company/1"

  describe "when saving", ->
    beforeEach ->
      @server = sinon.fakeServer.create()
      @responseBody = "{\"name\":\"My Company\",\"address\":\"M Street 56thNW\",\"city\":\"Washington D.C.\",\"country\":\"USA\",\"email\":\"email@domain.com\",\"phone\":123456}"
      @server.respondWith "POST", "/api/v1/company", [
        200
        {
          "Content-Type": "application/json"
        }
        @responseBody
      ]
      @eventSpy = sinon.spy()

    afterEach ->
      @server.restore()

    it "should not save when name is empty", ->
      @company.bind "validated:invalid", @eventSpy
      @company.save name: ""
      # move this into a create model action and create our company on runtime
      #expect(@company.isValid()).toBeFalsy()
      expect(@company.validationError).toEqual( name: ["name can't be blank"])

    it "should not save when address is empty", ->
      @company.bind "validated:invalid", @eventSpy
      @company.save address: ""
      expect(@company.validationError).toEqual( address: ["address can't be blank"])

    it "should make a save request to the server", ->
      @company.save()
      expect(@server.requests[0].method).toEqual "POST"
      expect(@server.requests[0].url).toEqual "/api/v1/company"
      expect(JSON.parse(@server.requests[0].requestBody)).toEqual @company.attributes

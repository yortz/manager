describe "Companies collection", ->
  beforeEach ->
    @company1 = new Backbone.Model(
      id: 1
      name: "Company 1"
      address: "M Street 56th NW"
      city: "Washington D.C."
      country: "USA"
      email: "email@domain.com"
      phone: 123456
    )
    @company2 = new Backbone.Model(
      id: 2
      name: "Company 2"
      address: "U Street 34 NW"
      city: "Washington D.C."
      country: "USA"
      email: "email@mymail.com"
      phone: 12345667
    )
    @company3 = new Backbone.Model(
      id: 3
      name: "Company 3"
      address: "M street 45"
      city: "Washington D.C."
      country: "USA"
      email: "email@domain.com"
      phone: 123456
    )
    @company4 = new Backbone.Model(
      id: 4
      name: "Company 4"
      name: "My Company"
      address: "M Street 56th NW"
      city: "Washington D.C."
      country: "USA"
      email: "email@domain.com"
      phone: 12345654
    )
    @companies = new frontend.collections.Companies()
    @companyStub = sinon.stub(window.frontend.models, "Company")

  afterEach ->
    @companyStub.restore()

  describe "When instantiated with model literal", ->
    beforeEach ->
      @model = new Backbone.Model(
        id: 5
        name: "My Company"
        address: "M Street 56th NW"
        city: "Washington D.C."
        country: "USA"
        email: "email@domain.com"
        phone: 123456
      )
      @companyStub.returns @model
      @companies.model = frontend.models.Company
      @companies.add
        id: 5
        name: "My Company"
        address: "M Street 56th NW"
        city: "Washington D.C."
        country: "USA"
        email: "email@domain.com"
        phone: 123456


    it "should have 1 Company model", ->
      expect(@companies.length).toEqual 1
      expect(@companyStub).toHaveBeenCalled()

    it "should find a model by id", ->
      expect(@companies.get(5).get("id")).toEqual @model.get("id")

    it "should find a model by index", ->
      expect(@companies.at(0).get("id")).toEqual @model.get("id")

    it "should have called the Company constructor", ->
      expect(@companyStub).toHaveBeenCalledOnce()
      expect(@companyStub).toHaveBeenCalledWith
        id: 5
        name: "My Company"
        address: "M Street 56th NW"
        city: "Washington D.C."
        country: "USA"
        email: "email@domain.com"
        phone: 123456

  describe "when fetching collection from server", ->
    beforeEach ->
      @fixture = @fixtures.Companies.valid
      @fixtureCompanies = @fixture.response.companies
      @server = sinon.fakeServer.create()
      @server.respondWith "GET", "/api/v1/companies", @validResponse(@fixture)

    afterEach ->
      @server.restore()

    it "should make the correct request", ->
      @companies.fetch()
      expect(@server.requests.length).toEqual 1
      expect(@server.requests[0].method).toEqual "GET"
      expect(@server.requests[0].url).toEqual "/api/v1/companies"

    it "should parse the companies from the response", ->
      @companies.fetch()
      @server.respond()
      expect(@companies.length).toEqual @fixture.response.companies.length
      expect(@companies.get(1).get("name")).toEqual @fixture.response.companies[0].name
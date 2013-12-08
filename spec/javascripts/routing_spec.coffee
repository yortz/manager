describe "Routes", ->
  describe "companies", ->
    it "should have an index route", ->
      expect(frontend.Routes.companies).toEqual "companies"
    it "should have a resource route", ->
      expect(frontend.Routes.company).toEqual "companies/:id"
    it "should have an edit route", ->
      expect(frontend.Routes.editCompany).toEqual "companies/:id/edit"
    it "should have a new route", ->
      expect(frontend.Routes.newCompany).toEqual "companies/new"

describe "Paths", ->
  describe "companies", ->
    it "should have an index path", ->
      expect(frontend.Paths.companies()).toEqual "/companies"
    it "should have a resource path", ->
      expect(frontend.Paths.company(4)).toEqual "/companies/4"
    it "should have an edit path", ->
      expect(frontend.Paths.editCompany(4)).toEqual "/companies/4/edit"
    it "should have a new path", ->
      expect(frontend.Paths.newCompany()).toEqual "/companies/new"

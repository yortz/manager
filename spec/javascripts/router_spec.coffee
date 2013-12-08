describe "Router", ->
  root = "/"
  router = null
  spy    = null
  $el = null

  beforeEach ->
    router = new frontend.Router routes: frontend.Routes, $el: $el
    spy = jasmine.createSpy("RouteEvent")
    Backbone.history.start

  afterEach -> expect(spy).toHaveBeenCalled()

  it "should route to companies index", ->
    router.on('route:companies', spy())
    frontend.navigate(frontend.Paths.companies())

  it "should route to a company", ->
    router.on('route:company', spy())
    frontend.navigate(frontend.Paths.company(1))

  it "should route to edit company", ->
    router.on('route:editCompany', spy())
    frontend.navigate(frontend.Paths.editCompany(1))

  it "should route to new company", ->
    router.on('route:newCompany', spy())
    frontend.navigate(frontend.Paths.newCompany())

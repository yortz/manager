describe "CompanyView", ->
  beforeEach ->
    @model = new Backbone.Model(
      id: 1
      name: "Company 1"
      address: "M Street 56th NW"
      city: "Washington D.C."
      country: "USA"
      email: "email@domain.com"
      phone: 123456
    )
    @view = new frontend.views.Company(
      model: @model
      template: @templates.company
    )
    setFixtures "<ul class=\"companies\"></ul>"

  it "loads the Company template", ->
    expect(@templates.company).toBeDefined()

  describe "Root element", ->
    it "is a LI", ->
      expect(@view.el.nodeName).toEqual "LI"

  describe "Rendering", ->
    it "returns the view object", ->
      expect(@view.render()).toEqual @view

    # The following is a brittle test. It's best to
    # test for specific nodes and attributes using
    # the jasmine-jquery plugin matchers
    it "produces the correct HTML", ->
      @view.render()
      expect(@view.el.innerHTML).toEqual "<a href=\"#company/1\"><h2>Company 1</h2></a>"

    describe "Template", ->
      beforeEach ->
        $("ul.companies").append @view.render().el

      it "has the correct URL", ->
        expect($(@view.el).find("a")).toHaveAttr "href", "#company/1"

      it "has the correct name text", ->
        expect($(@view.el).find("h2")).toHaveText "Company 1"

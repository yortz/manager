describe "CompaniesView", ->
  beforeEach ->
    @companies = new frontend.collections.Companies()
    @view = new frontend.views.Companies(collection: @companies)

  describe "Instantiation", ->
    it "should create a list element", ->
      expect(@view.el.nodeName).toEqual "UL"
  
    it "should have a class of 'companies'", ->
      expect($(@view.el)).toHaveClass "companies"


  describe "Rendering", ->
    beforeEach ->
      @companyView = new Backbone.View()
      @companyView.render = ->
        @el = document.createElement("li")
        @
  
      @companyRenderSpy = sinon.spy(@companyView, "render")
      @companyViewStub = sinon.stub(window.frontend.views, "Company").returns(@companyView)
      @company1 = new Backbone.Model(id: 1)
      @company2 = new Backbone.Model(id: 2)
      @company3 = new Backbone.Model(id: 3)
      @view.collection = new Backbone.Collection([
        @company1
        @company2
        @company3
      ])
      @view.render()
  
    afterEach ->
      window.frontend.views.Company.restore()
  
    it "creates a Company view for each company item", ->
      expect(@companyViewStub).toHaveBeenCalledThrice()
      expect(@companyViewStub).toHaveBeenCalledWith model: @company1
      expect(@companyViewStub).toHaveBeenCalledWith model: @company2
      expect(@companyViewStub).toHaveBeenCalledWith model: @company3
  
    it "renders each Company view", ->
      expect(@companyRenderSpy).toHaveBeenCalledThrice()
  
    it "appends the company to the company list", ->
      expect($(@view.el).find('li').length).toEqual 3

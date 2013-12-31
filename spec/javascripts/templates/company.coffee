beforeEach ->
  @templates = _.extend(@templates or {},
    company: "<a href=\"#company/{{company.id}}\">" + "<h2>{{company.name}}</h2>" + "</a>"
  )

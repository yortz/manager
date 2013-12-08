afterEach ->
  if Backbone.History.started
    Backbone.history.navigate("")
    Backbone.history.stop()


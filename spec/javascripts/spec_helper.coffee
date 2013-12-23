beforeEach ->
  @validResponse = (responseText) ->
    [
      200
      {
        "Content-Type": "application/json"
      }
      JSON.stringify(responseText)
    ]

afterEach ->
  if Backbone.History.started
    Backbone.history.navigate("")
    Backbone.history.stop()


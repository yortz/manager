$ ->
  $el = $(".companies")
  router = new frontend.Router routes: frontend.Routes, $el: $el
  Backbone.history.start pushState: true if !Backbone.History.started

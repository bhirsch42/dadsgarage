Router.route '/', ->
  @render ActivePage.get()

Router.route '/admin', ->
  @render Template.admin

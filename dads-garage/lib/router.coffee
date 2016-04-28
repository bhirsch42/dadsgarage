Router.route '/', ->
  @render 'user_' + ActivePage.get().template

Router.route '/stage', ->
  @render 'stage_' + ActivePage.get().template

Router.route '/admin', ->
  @render 'admin'

Router.route '/performer', ->
  @render 'performer'

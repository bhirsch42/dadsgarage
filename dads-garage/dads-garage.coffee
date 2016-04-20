if Meteor.isServer
  Meteor.startup ->
    ActivePage.remove {}
    ActivePage.set 'home'

if Meteor.isClient
  @UserId = Cookie.get 'dads-garage-uid'
  if not @UserId
    @UserId = User.insert {}
    Cookie.set 'dads-garage-uid', @UserId

  @CurrentUser = User.findOne @UserId

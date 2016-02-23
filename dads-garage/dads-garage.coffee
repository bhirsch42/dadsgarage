if Meteor.isServer
  ActivePage.remove {}
  ActivePage.set 'home'

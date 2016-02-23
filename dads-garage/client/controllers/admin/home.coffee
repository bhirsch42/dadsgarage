if Meteor.isClient
  Template.admin_home.events
    'click .button.show': ->
      ActivePage.set 'home'

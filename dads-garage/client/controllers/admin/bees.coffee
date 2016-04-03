if Meteor.isClient
  Template.admin_bees.events
    'click .show': ->
      ActivePage.set 'bees'

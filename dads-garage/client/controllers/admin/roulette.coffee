if Meteor.isClient
  Template.admin_roulette.events
    'click .button.show': ->
      ActivePage.set 'roulette'



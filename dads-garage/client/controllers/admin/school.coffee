if Meteor.isClient
  Template.admin_school.events
    'click .button.show': ->
      ActivePage.set 'school'

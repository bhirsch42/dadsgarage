if Meteor.isClient
  Template.admin_get_photo.events
    'click .button.show': ->
      ActivePage.set 'get_photo'

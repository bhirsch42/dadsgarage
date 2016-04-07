if Meteor.isClient
  Template.admin_dating_profile.events
    'click .button.show': ->
      ActivePage.set 'dating_profile'

  Template.admin_dating_profile.helpers
    'click .button.oldest': ->
      $('#getOldest').empty()
      $('#getOldest') = DatingProfile.getOldest()

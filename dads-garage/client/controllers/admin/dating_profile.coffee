if Meteor.isClient
  Template.admin_dating_profile.events
    'click .button.show': ->
      ActivePage.set 'dating_profile'

    'click .button.oldest': ->
      $('#getOldest').empty()
      $('#getOldest').html DatingProfile.getOldest()

  Template.admin_dating_profile.helpers
    'oldest': ->
      oldest = DatingProfile.getOldest()
      oldest.fName + ' ' + oldest.lName


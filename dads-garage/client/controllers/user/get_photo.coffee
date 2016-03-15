if Meteor.isClient
  Template.user_get_photo.rendered = ->
    MeteorCamera.getPicture()

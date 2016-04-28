if Meteor.isClient

  Template.user_bees.events
    'touchstart .button, mousedown .button': ->
      SimplePick.add UserId, 1, SimpleVote.get()._id
      $('.user-music-torture').addClass 'active'

    'touchend .button, mouseup .button': ->
      SimplePick.add UserId, 2, SimpleVote.get()._id
      $('.user-music-torture').removeClass 'active'

if Meteor.isClient

  Template.user_music_torture.events
    'touchstart .button': ->
      SimplePick.add UserId, 1, SimpleVote.get()._id
      $('.user-music-torture').addClass 'active'

    'touchend .button': ->
      SimplePick.add UserId, 2, SimpleVote.get()._id
      $('.user-music-torture').removeClass 'active'


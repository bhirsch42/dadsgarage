if Meteor.isClient

  Template.user_music_torture.events
    'touchstart .button, mousedown .button': ->
      SimplePick.add UserId, 1, SimpleVote.get()._id
      $('.user-music-torture').addClass 'active'

    'touchend .button, mouseup .button': ->
      SimplePick.add UserId, 2, SimpleVote.get()._id
      $('.user-music-torture').removeClass 'active'

  # Template.user_music_torture.rendered = ->
  #   SimplePick.add UserId, 2, SimpleVote.get()._id

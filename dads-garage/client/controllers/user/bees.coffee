if Meteor.isClient
  bees = false
  Template.user_bees.events
    'touchend .bees-button, mouseup .bees-button': _.debounce (e) ->
      console.log 'click .bees-button'
      if bees
        $('.bees').removeClass 'on'
        bees = false
      else
        $('.bees').addClass 'on'
        bees = true

      user.bees = bees
      User.update user._id, user
    , 20, true

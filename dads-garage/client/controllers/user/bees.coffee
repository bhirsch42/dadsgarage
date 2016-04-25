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

      CurrentUser.bees = bees
      User.update CurrentUser._id, CurrentUser
    , 20, true

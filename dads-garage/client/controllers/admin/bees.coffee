if Meteor.isClient

  playingSound = false
  updateBees = ->
    bees = User.find(bees: true).count()
    noBees = User.find(bees: false).count()
    console.log 'updateBees', bees, noBees
    if bees >= noBees
      if playingSound
        return
      MyMusic.playOnly name: 'sounds/bees.mp3'
      playingSound = true
    else
      playingSound = false
      MyMusic.stopAllMusic()



  Template.admin_bees.created = ->
    User.find({bees: {$ne:null}}).observe
      'added': ->
        updateBees()
      'changed': ->
        updateBees()

  Template.admin_bees.rendered = ->
    MyMusic.fadeTime = 0

  Template.admin_bees.events
    'click .show': ->
      ActivePage.set 'bees'
    'click #clear-users': ->
      User.find({}).forEach (user) ->
        user.bees = null
        User.update user._id, user

  Template.admin_bees.helpers
    'bees': ->
      return User.find(bees: true).count()
    'no_bees': ->
      return User.find(bees: false).count()

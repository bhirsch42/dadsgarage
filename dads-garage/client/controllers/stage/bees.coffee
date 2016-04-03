if Meteor.isClient

  updateBees = ->
    bees = User.find(bees: true).count()
    noBees = User.find(bees: false).count()
    h = bees / (bees + noBees) * 100
    console.log 'updateBees', bees, noBees, h, h + 'vh'
    $beeBar = $('.bee-bar').css 'height', h + 'vh'

  Template.stage_bees.created = ->
    User.find({bees: {$ne:null}}).observe
      'added': ->
        updateBees()
      'changed': ->
        updateBees()

  Template.stage_bees.rendered = ->
    updateBees()

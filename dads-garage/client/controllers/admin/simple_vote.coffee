if Meteor.isClient
  Template.admin_simple_vote.events
    'click .button.start-vote': (e) ->
      SimpleVote.add parseInt $(e.target).data 'num-options'
      ActivePage.set 'simple_vote'

    'click .button.stop-vote': ->
      simpleVote = SimpleVote.get()
      simpleVote.isOver = true
      SimpleVote.update simpleVote._id, simpleVote

    'click .show-home': ->
      ActivePage.set 'home'

  Template.admin_simple_vote.helpers
    button: ->
      [1..6].map (i) ->
        numOptions: i


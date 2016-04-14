if Meteor.isClient
  Template.admin_simple_vote.events
    'input input.num-options': ->
      $('.options').html $('input.num-options').val()

    'click .button.start-vote': ->
      SimpleVote.add parseInt $('input.num-options').val()
      ActivePage.set 'simple_vote'

    'click .button.stop-vote': ->
      simpleVote = SimpleVote.get()
      simpleVote.isOver = true
      SimpleVote.update simpleVote._id, simpleVote



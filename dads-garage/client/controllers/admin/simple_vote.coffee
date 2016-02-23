if Meteor.isClient
  Template.admin_simple_vote.events
    'input input.num-options': ->
      $('.options').html $('input.num-options').val()

    'click .button.start-vote': ->
      SimpleVote.add parseInt $('input.num-options').val()
      ActivePage.set 'simple_vote'


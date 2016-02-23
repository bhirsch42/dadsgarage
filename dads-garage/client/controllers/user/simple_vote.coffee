if Meteor.isClient
  Template.user_simple_vote.helpers
    'options': ->
      [1..SimpleVote.get().numOptions]

  Template.user_simple_vote.events
    'click .option': (e) ->
      value = $(e.target).data 'value'
      SimplePick.add value, SimpleVote.get()._id


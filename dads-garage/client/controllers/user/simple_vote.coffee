if Meteor.isClient
  Template.user_simple_vote.helpers
    'options': ->
      [1..SimpleVote.get().numOptions]

  Template.user_simple_vote.events
    'click .option': (e) ->
      $target = $(e.target)
      value = $target.data 'value'
      SimplePick.add UserId, value, SimpleVote.get()._id
      $('.selected').removeClass 'selected'
      $target.addClass 'selected'

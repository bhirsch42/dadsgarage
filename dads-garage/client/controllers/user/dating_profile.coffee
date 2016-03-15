if Meteor.isClient
  Template.user_dating_profile.helpers
    'options': ->
      [1..SimpleVote.get().numOptions]

  Template.user_simple_vote.events
    'click .option': (e) ->
      value = $(e.target).data 'value'
      dating_profile.add l_name, f_name, age, questions

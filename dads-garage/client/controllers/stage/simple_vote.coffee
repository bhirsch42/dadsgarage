if Meteor.isClient
  Template.stage_simple_vote.helpers
    'results': ->
      _.toArray SimpleVote.results()

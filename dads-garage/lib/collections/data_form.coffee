@SimpleVote = new Mongo.Collection 'simple_vote'

@SimpleVote.add = (numOptions) ->
  SimpleVote.insert numOptions: numOptions, time: Date.now()

@SimpleVote.get = ->
  simpleVote = SimpleVote.findOne({}, {sort: {time: -1, limit: 1}})
  return simpleVote

@SimpleVote.results = ->
  simpleVote = SimpleVote.get()
  results = {}
  for i in [1..simpleVote.numOptions]
    results[i] = SimplePick.find(option: i, simpleVoteId: simpleVote._id).count()
  return results

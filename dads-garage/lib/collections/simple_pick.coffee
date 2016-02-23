@SimplePick = new Mongo.Collection 'simple_pick'

@SimplePick.add = (option, simpleVoteId) ->
  SimplePick.insert option: option, simpleVoteId: simpleVoteId, time: Date.now()

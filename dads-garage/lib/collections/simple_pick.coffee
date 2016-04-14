@SimplePick = new Mongo.Collection 'simple_pick'

@SimplePick.add = (uid, option, simpleVoteId) ->
  pick = SimplePick.findOne uid: uid
  if pick
    pick.option = option
    pick.simpleVoteId = simpleVoteId
    SimplePick.update pick._id, pick
  else
    SimplePick.insert uid: uid, option: option, simpleVoteId: simpleVoteId, time: Date.now()

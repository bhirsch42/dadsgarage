@MusicPosition = new Mongo.Collection 'music_position'

@MusicPosition.add = (userId, x, y) ->
  mp = MusicPosition.findOne userId: userId
  if not mp
    mp = MusicPosition.insert userId: userId, x: x, y: y
  else
    mp.x = x
    mp.y = y
    MusicPosition.update mp._id, mp

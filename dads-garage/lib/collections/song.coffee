@Song = new Mongo.Collection 'song'

@Song.add = (name) ->
  if Song.findOne(name: name)
    return
  Song.insert name: name, position: null

@DatingProfile = new Mongo.Collection 'dating_profile'

@DatingProfile.add = (lName, fName, age, occupation, homeCity, favDrink,
favFood, favMusic, favTVShow) ->
  DatingProfile.insert lName: lname, fName: fName, age: age,
  occupation: occupation, homeCity: homeCity, favDrink: favDrink,
  favFood: favFood,favMusic: favMusic, favTVShow: favTVShow

@DatingProfile.getYoungest = ->
  DatingProfile.find.sort({age: 1}).limit(1)

@DatingProfile.getOldest = ->
  DatingProfile.find.sort({age: -1}).limit(1)

@DatingProfile.getRandomOccupation = ->
  DatingProfile.find.sort({occupation: -1}).limit(-1).skip(rand()).next()

@DatingProfile.getRandomHomeCity = ->
  DatingProfile.find.sort({homeCity: -1}).limit(-1).skip(rand()).next()

@DatingProfile.getRandomFavDrink = ->
  DatingProfile.find.sort({favDrink: -1}).limit(-1).skip(rand()).next()

@DatingProfile.getRandomFavFood = ->
  DatingProfile.find.sort({favFood: -1}).limit(-1).skip(rand()).next()

@DatingProfile.getRandomFavMusic = ->
  DatingProfile.find.sort({favMusic: -1}).limit(-1).skip(rand()).next()

@DatingProfile.getRandomFavTVShow = ->
  DatingProfile.find.sort({favTVShow: -1}).limit(-1).skip(rand()).next()

@DatingProfile = new Mongo.Collection 'dating_profile'

@DatingProfile.add = (lName, fName, age, questions) ->
  DatingProfile.insert lName: lName, fName: fName, age: age,
  questions: questions
  # [occupation,  homeCity,  favDrink, favFood, favMusic, favMovieGenre,
  #   favTVShow, laugh, motherlyAdvice, petPeeve, attractive,
  #   embarrssedAudience, colour, favFirstDate]

@DatingProfile.getYoungest = ->
  DatingProfile.findOne({}, {age: 1, limit: 1})

@DatingProfile.getOldest = ->
  DatingProfile.findOne({}, {age: -1, limit: 1})

@DatingProfile.getRandomOccupation = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[0]

@DatingProfile.getRandomHomeCity = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[1]

@DatingProfile.getRandomFavDrink = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[2]

@DatingProfile.getRandomFavFood = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[3]

@DatingProfile.getRandomFavMusic = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[4]

@DatingProfile.getRandomFavMovieGenre = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[5]

@DatingProfile.getRandomFavTVShow = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[6]

@DatingProfile.getRandomLaugh = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[7]

@DatingProfile.getRandomMotherlyAdvice = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[8]

@DatingProfile.getRandomPetPeeve = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[9]

@DatingProfile.getRandomAttractive = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[10]

@DatingProfile.getRandomEmbarrassedAudience = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[11]

@DatingProfile.getRandomColour = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[12]

@DatingProfile.getRandomFavFirstDate = ->
  array = DatingProfile.find().fetch()
  randomIndex = Math.floor(Math.random() * array.length)
  element = array[randomIndex].questions[13]
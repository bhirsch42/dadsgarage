if Meteor.isClient
  Template.admin_dating_profile.events
    'click .button.show': ->
      ActivePage.set 'dating_profile'
    'click input[value=text]': ->
      
      question = $('input[name=question]').val()
      #Store data on server
      #use for loop to pull data and inject html
      questions.add question, 'text'


    'click .button.occupation': ->
      $('#getRandomOccupation').empty()
      $('#getRandomOccupation').html DatingProfile.getRandomOccupation()
    'click .button.homeCity': ->
      $('#getRandomHomeCity').empty()
      $('#getRandomHomeCity').html DatingProfile.getRandomHomeCity()
    'click .button.favDrink': ->
      $('#getRandomFavDrink').empty()
      $('#getRandomFavDrink').html DatingProfile.getRandomFavDrink()
    'click .button.favFood': ->
      $('#getRandomFavFood').empty()
      $('#getRandomFavFood').html DatingProfile.getRandomFavFood()
    'click .button.favMusic': ->
      $('#getRandomFavMusic').empty()
      $('#getRandomFavMusic').html DatingProfile.getRandomFavMusic()
    'click .button.favMovieGenre': ->
      $('#getRandomFavMovieGenre').empty()
      $('#getRandomFavMovieGenre').html DatingProfile.getRandomFavMovieGenre()
    'click .button.favTVShow': ->
      $('#getRandomFavTVShow').empty()
      $('#getRandomFavTVShow').html DatingProfile.getRandomFavTVShow()
    'click .button.laugh': ->
      $('#getRandomLaugh').empty()
      $('#getRandomLaugh').html DatingProfile.getRandomLaugh()
    'click .button.motherlyAdvice': ->
      $('#getRandomMotherlyAdvice').empty()
      $('#getRandomMotherlyAdvice').html DatingProfile.getRandomMotherlyAdvice()
    'click .button.petPeeve': ->
      $('#getRandomPetPeeve').empty()
      $('#getRandomPetPeeve').html DatingProfile.getRandomPetPeeve()
    'click .button.attractive': ->
      $('#getRandomAttractive').empty()
      $('#getRandomAttractive').html DatingProfile.getRandomAttractive()
    'click .button.embarrassedAudience': ->
      $('#getRandomEmbarrassedAudience').empty()
      $('#getRandomEmbarrassedAudience').html DatingProfile.getRandomEmbarrassedAudience()
    'click .button.colour': ->
      $('#getRandomColour').empty()
      $('#getRandomColour').html DatingProfile.getRandomColour()
    'click .button.favFirstDate': ->
      $('#getRandomFavFirstDate').empty()
      $('#getRandomFavFirstDate').html DatingProfile.getRandomFavFirstDate()

  Template.admin_dating_profile.helpers
    'youngest': ->
      youngest = DatingProfile.getYoungest()
      youngest.fName + ' ' + youngest.lName
    'oldest': ->
      oldest = DatingProfile.getOldest()
      oldest.fName + ' ' + oldest.lName

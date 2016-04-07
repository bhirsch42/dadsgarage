if Meteor.isClient
  Template.admin_dating_profile.events
    'click .button.show': ->
      ActivePage.set 'dating_profile'
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


  Template.admin_dating_profile.helpers
    'youngest': ->
      youngest = DatingProfile.getYoungest()
      youngest.fName + ' ' + youngest.lName
    'oldest': ->
      oldest = DatingProfile.getOldest()
      oldest.fName + ' ' + oldest.lName
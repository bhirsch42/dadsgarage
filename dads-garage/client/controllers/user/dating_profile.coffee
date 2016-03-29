if Meteor.isClient
  Template.user_dating_profile.helpers
    'options': ->
      [1..SimpleVote.get().numOptions]

  Template.user_dating_profile.events
    'submit': (e) ->
      e.preventDefault()
      l_name = $('input[name=l_name]').val()
      f_name = $('input[name=f_name]').val()
      age = $('input[name=age]').val()
      # QUESTIONS
      occupation = $('input[name=occupation]').val()
      home_city = $('input[name=home_city]').val()
      fave_drink = $('input[name=fave_drink]').val()
      fave_food= $('input[name=fave_food]').val()
      fave_music= $('input[name=fave_music]').val()
      fave_TV_show= $('input[name=fave_TV_show]').val()
      questions = [occupation, home_city, fave_drink, fave_food, fave_music, fave_TV_show]
      DatingProfile.add l_name, f_name, age, questions

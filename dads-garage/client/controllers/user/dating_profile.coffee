if Meteor.isClient
  # @Questions = new Mongo.Collection 'questions'
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
      fave_movie_genre= $('input[name=fave_movie_genre]').val()
      fave_TV_show= $('input[name=fave_TV_show]').val()
      laugh= $('input[name=laugh]').val()
      motherly_advice= $('input[name=motherly_advice]').val()
      pet_peeve= $('input[name=pet_peeve]').val()
      attractive= $('input[name=attractive]').val()
      embarrassed_audience= $('input[name=embarrassed_audience]').val()
      underwear_colour= $('input[name=underwear_colour]').val()
      first_date= $('input[name=first_date]').val()
      questions = [occupation, home_city, fave_drink, fave_food, fave_music,
        fave_movie_genre, fave_TV_show, laugh, motherly_advice, pet_peeve,
        attractive, embarrassed_audience, underwear_colour, first_date]
      DatingProfile.add l_name, f_name, age, questions
      $('#form').empty()
      Blaze.render(Template.user_dating_profile2,$('#form')[0])

if Meteor.isClient
  # @Questions = new Mongo.Collection 'questions'
  Template.user_dating_profile.events
    'submit': (e) ->
      e.preventDefault()
      # QUESTIONS
      size = Questions.getSize()-1
      answer = [size]
      if size > 0
        for i in [0..size]
          answer[i] = $('input[id=\'' + i + '\']').val()
        DatingProfile.add answer

      $('#form').empty()
      Blaze.render(Template.user_dating_profile2,$('#form')[0])
      DatingProfile.getData()

if Meteor.isClient
  Template.user_dating_profile.onRendered ->
    size = Questions.getSize()-1
    if size > 0
      for i in [0..size]
        question = Questions.getQuestions(i)

        if question[1] == "text" 
          newContent = '<div>' + question[0] + '<br>' + '<input id=\'' + i + '\' type=\'' + question[1] + '\'>' + '</div>'

        if question[1] == "file" 
          newContent = '<div>' + question[0] + '<br>' + '<input id=\'' + i + i + '\' type=\'' + question[1] + '\'>' + '</div>'

        $('#insideForm').append newContent

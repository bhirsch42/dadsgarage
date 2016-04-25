if Meteor.isClient
  Template.user_questions.helpers
    question: ->
      questions = Question.find({}).fetch()
      questions = questions.map (q) ->
        q.typeIsText = q.type == 'text'
        q.typeIsPhoto = q.type == 'photo'
        q
      questions

  Template.user_questions.events
    'change input[type=file]': (e) ->
      files = e.target.files

      reader = new FileReader()
      reader.onload = (e) ->
        Imgur.upload {apiKey: 'fa756eb4cda199f', image: e.target.result}, (error, data) ->
          console.log error, data
      reader.readAsDataURL files[0]

    'click #submit': (e) ->
      $('input[type=text]').each (i, o) ->
        console.log "$(o).data('question-id')", $(o).data('question-id')
        console.log "$(o).val()", $(o).val()
        QuestionAndAnswer.add UserId, $(o).data('question-id'), $(o).val()
        $('.user-questions-wrapper').empty()
        $('.user-questions-wrapper').html("Thank you!")

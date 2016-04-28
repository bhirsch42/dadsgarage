if Meteor.isClient
  pictureData = {}

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
      questionId = $(e.target).data('question-id')
      reader = new FileReader()
      reader.onload = (e) ->
        $('.preview[data-question-id=' + questionId + ']').attr('src', e.target.result)
      reader.readAsDataURL files[0]

    'click #submit': (e) ->
      $('input[type=text]').each (i, o) ->
        if $(o).val().length > 0
          QuestionAndAnswer.add UserId, $(o).data('question-id'), $(o).val()
      $('input[type=file]').each (i, o) ->
        files = o.files
        if files.length > 0
          reader = new FileReader()
          reader.onload = (e) ->
            console.log 'reader.onload', o
            Imgur.upload {apiKey: 'fa756eb4cda199f', image: e.target.result}, (error, data) ->
              QuestionAndAnswer.add UserId, $(o).data('question-id'), data.link
          try
            reader.readAsDataURL files[0]
          catch error
            console.log error


        $('.user-questions-wrapper').empty()
        $('.user-questions-wrapper').html("Thank you!")
        setTimeout ->
          $parent = $('.user-questions-wrapper')
          $parent.empty()
          Blaze.render Template['user_home'], $parent[0]
        , 5000


if Meteor.isClient
  Template.admin_questions.helpers
    question: ->
      Question.find {}
    'count': (questionId) ->
      QuestionAndAnswer.getCount(questionId)
    'entries': (questionId) ->
      array = QuestionAndAnswer.get(questionId)
      text = []
      #int i;
      i = 0
      while i < array.length
        text += array[i].answer + ', '
        i++
      text




  Template.admin_questions.events
    'click .button.show': ->
      ActivePage.set 'questions'

    'click #create-question': (e) ->
      questionText = $('#question-text').val()
      questionType = $('input[name=type]:checked').val()

      Question.add questionType, questionText

    'click .remove-question': (e) ->
      Question.remove $(e.target).data 'question-id'

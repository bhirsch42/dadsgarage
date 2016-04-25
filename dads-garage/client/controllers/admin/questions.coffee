if Meteor.isClient
  Template.admin_questions.helpers
    question: ->
      Question.find {}

  Template.admin_questions.events
    'click .button.show': ->
      ActivePage.set 'questions'

    'click #create-question': (e) ->
      questionText = $('#question-text').val()
      questionType = $('input[name=type]:checked').val()

      Question.add questionType, questionText

    'click .remove-question': (e) ->
      Question.remove $(e.target).data 'question-id'

if Meteor.isClient
  Template.performer.helpers
   'question': ->
    Question.find {}

  Template.performer.events
    'click .button': (e) ->
      qid = $(e.target).data 'question-id'
      answers = QuestionAndAnswer.find questionId: qid
      $('#content').empty()
      Blaze.renderWithData Template.answer_list, answer: answers, $('#content')[0]




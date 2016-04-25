@Question = new Mongo.Collection 'question'

@Question.add = (type, text) ->
  Question.insert type: type, text: text


@QuestionAndAnswer = new Mongo.Collection 'question_and_answer'

@QuestionAndAnswer.add = (userId, questionId, answer) ->
  QuestionAndAnswer.insert userId: userId, questionId: questionId, answer: answer, created: Date.now()

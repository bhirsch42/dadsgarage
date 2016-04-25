@Questions = new Mongo.Collection 'questions'

@Questions.add = (question, type) ->
  DatingProfile.insert question: question, type: type

@Questions.getQuestions = (index) ->
  array = Questions.find().fetch()
  question = array[index].question
  type = array[index].type
  element = [question, type]

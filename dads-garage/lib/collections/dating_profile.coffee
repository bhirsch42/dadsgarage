@DatingProfile = new Mongo.Collection 'dating_profile'

@DatingProfile.add = (answers) ->
  #answer is [hello, my, name, is, bob]
  DatingProfile.insert answers: answers

@DatingProfile.getData = ->
  array = DatingProfile.find().fetch()
  size = array.length-1
  newArray = [[], []]
  
  if size >= 0 
    innerSize = array[0].answers.length-1
    if innerSize >= 0
      for i in [0..innerSize]
        for j in [0..size]
          newArray[j] += array[j].answers[i] + ' '
  console.log(newArray)
  element = newArray

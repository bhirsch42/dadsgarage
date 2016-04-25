if Meteor.isClient
  Template.admin_dating_profile.events
    'click .button.show': ->
      ActivePage.set 'dating_profile'
    'click input[value=text]': ->      
      question = $('input[name=question]').val()
      newContent = '<div>' + question + ' - text' + '</div>'
      $('#questionsEntered').append newContent
      Questions.add question, 'text'
      $('input[value=text]').empty()

    'click input[value=image]': ->      
      question = $('input[name=question]').val()
      newContent = '<div>' + question + ' - image' + '</div>'
      $('#questionsEntered').append newContent
      Questions.add question, 'file'
      $('input[value=image]').empty()

    'click .button.getData': ->
      $('#getData').empty()
      x = DatingProfile.getData()
      size = x.length-1
      if size >= 0
        newContent = ''
        for i in [0..size]
            y = x[i]
            newContent += '<div>Question' + i + ': ' + y + '</div>'
        $('#getData').append newContent

  Template.admin_dating_profile.helpers
    'youngest': ->
      youngest = DatingProfile.getYoungest()
      youngest.fName + ' ' + youngest.lName
    'oldest': ->
      oldest = DatingProfile.getOldest()
      oldest.fName + ' ' + oldest.lName

if Meteor.isClient
  Template.admin_dating_profile.onRendered ->
    size = Questions.getSize()-1
    if size >= 0
      for i in [0..size]
        question = Questions.getQuestions(i)
        newContent = '<div>' + question[0] + ' - ' + question[1]  + '</div>'
        $('#questionsEntered').append newContent

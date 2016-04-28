if Meteor.isClient
  Template.stage_roulette.helpers
    'people': ->
      photoQuestion = Question.findOne text: 'Upload a selfie of just you.'
      nameQuestion = Question.findOne text: 'What is your name?'
      people = []
      QuestionAndAnswer.find({questionId: photoQuestion._id}).forEach (photo) ->
        name = QuestionAndAnswer.findOne questionId: nameQuestion._id, userId: photo.userId
        if name
          people.push {photo: photo.answer, name: name.answer}
      people

  asyncCounterStart = 0
  asyncCounterEnd = 0
  total = 0
  Template.stage_roulette.rendered = ->
    people = $('.person')
    $('pass').removeClass 'pass'
    $('stop').removeClass 'stop'
    asyncCounterStart = 0
    asyncCounterEnd = 0
    total = 0


    spacing = 200
    animationLength = 1000
    r = Math.floor(Math.random() * people.length)
    total = people.length * 1 + r
    for i in [0..total]
      console.log i % people.length
      $person = $(people[i % people.length])
      timer = i * spacing

      setTimeout ->
        $person = $(people[asyncCounterStart % people.length])
        if asyncCounterStart == total - 1
          console.log 'stopping'
          $person.addClass 'stop'
        else
          $person.addClass 'pass'
        console.log 'start animation', $person
        asyncCounterStart++
      , timer

      setTimeout ->
        $person = $(people[asyncCounterEnd % people.length])
        $person.removeClass 'pass'
        console.log 'stop animation', $person
        asyncCounterEnd++
      , timer + animationLength


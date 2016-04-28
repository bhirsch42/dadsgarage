if Meteor.isClient
  activeSong = null
  average = null

  dist = (a, b) ->
    x = a.x - b.x
    y = a.y - b.y
    return Math.sqrt x * x + y * y


  updateAverage = ->
    users = MusicPosition.find {}
    total = {x: 0.0, y: 0.0}
    users.forEach (user) ->
      total.x += user.x
      total.y += user.y
    total.x /= users.count()
    total.y /= users.count()
    average = total

  drawSongCanvas = ->
    songs = Song.find {position: {$ne:null}}

    MusicPosition.find({}).forEach (pos) ->
      $('#' + pos._id).css
        top  : (pos.y * @$('.stage-music-grid').height()) + 'px'
        left : (pos.x * @$('.stage-music-grid').width()) + 'px'
    $('#average').css
      top  : (average.y * @$('.stage-music-grid').height()) + 'px'
      left : (average.x * @$('.stage-music-grid').width()) + 'px'


  update = ->
    updateAverage()
    drawSongCanvas()

  Template.stage_music_grid.rendered = ->
    update()

  Template.stage_music_grid.created = ->
    MusicPosition.find({}).observe
      'added': ->
        update()
      'changed': ->
        update()

  Template.stage_music_grid.helpers
    'position': ->
      positions = MusicPosition.find({}).fetch()
      question = Question.findOne text: 'Upload a selfie of just you.'
      qid = question._id
      for position in positions
        uid = position.userId
        qa = QuestionAndAnswer.findOne questionId: qid, userId: uid
        if qa
          position.imageLink = Imgur.toThumbnail(qa.answer, Imgur.SMALL_THUMBNAIL)
      console.log positions
      positions

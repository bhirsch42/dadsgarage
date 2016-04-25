if Meteor.isClient

  getMousePosition = (e) ->
    console.log 'getMousePosition', e
    return {
      x: e.clientX - $('.user-music-grid').offset().left
      y: e.clientY - $('.user-music-grid').offset().top
    }

  drawSongCanvas = ->
    mp = MusicPosition.findOne userId: UserId
    w = $('#point').width()
    h = $('#point').height()
    $('#point').css
      'top'  : (mp.y * $('.user-music-grid').height() - h / 2) + 'px'
      'left' : (mp.x * $('.user-music-grid').width() - w / 2) + 'px'

  updateMusicPosition = (e) ->
    mousePos = getMousePosition e
    console.log mousePos
    mousePos.x /= $('.user-music-grid').width()
    mousePos.y /= $('.user-music-grid').height()
    console.log mousePos
    MusicPosition.add UserId, mousePos.x, mousePos.y
    drawSongCanvas()

  mouseDown = false
  Template.user_music_grid.events
    'mousedown .user-music-grid': (e) ->
      mouseDown = true
      updateMusicPosition e

    'mousemove .user-music-grid': (e) ->
      if mouseDown
        updateMusicPosition e

    'mouseup .user-music-grid': (e) ->
      mouseDown = false

    'click .user-music-grid': (e) ->
      updateMusicPosition e

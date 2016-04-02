if Meteor.isClient
  canvas = null
  ratio = null

  CanvasUtils = {
    drawCircle: (ctx, x, y, r) ->
      ctx.beginPath()
      ctx.arc x, y, r, 0, 2 * Math.PI
      ctx.stroke()

    drawNormCircle: (ctx, x, y, r) ->
      ctx.beginPath()
      ctx.arc x * ctx.canvas.width / ratio, y * ctx.canvas.height / ratio, r, 0, 2 * Math.PI
      ctx.stroke()

    clear: (ctx) ->
      ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height
  }

  getCanvasMousePosition = (e) ->
    mx = e.clientX
    my = e.clientY
    rect = canvas.getBoundingClientRect()
    cx = rect.left
    cy = rect.top
    {x: (mx - cx) / canvas.width, y: (my - cy) / canvas.height}

  drawSongCanvas = ->
    w = canvas.width / ratio
    h = canvas.height / ratio
    ctx = canvas.getContext '2d'

    CanvasUtils.clear ctx

    ctx.font = '20px Lato'
    ctx.fillStyle = '#888888'
    ctx.textAlign = 'left'
    ctx.fillText 'Sad', 10, h/2
    ctx.textAlign = 'right'
    ctx.fillText 'Happy', w-10, h/2
    ctx.textAlign = 'center'
    ctx.fillText 'Intense', w/2, 24
    ctx.fillText 'Calm', w/2, h-10
    ctx.strokeStyle = '#000000'

    user = User.findOne userId

    if user.musicPosition
      CanvasUtils.drawNormCircle ctx, user.musicPosition.x, user.musicPosition.y, 10

  fixDeviceScaling = ->
    ctx = canvas.getContext '2d'
    devicePixelRatio = window.devicePixelRatio or 1
    backingStoreRatio = ctx.webkitBackingStorePixelRatio or ctx.mozBackingStorePixelRatio or ctx.msBackingStorePixelRatio or ctx.oBackingStorePixelRatio or ctx.backingStorePixelRatio or 1
    ratio = devicePixelRatio / backingStoreRatio
    if typeof auto == 'undefined'
      auto = true
    if auto and devicePixelRatio != backingStoreRatio
      oldWidth = canvas.width
      oldHeight = canvas.height
      canvas.width = oldWidth * ratio
      canvas.height = oldHeight * ratio
      canvas.style.width = oldWidth + 'px'
      canvas.style.height = oldHeight + 'px'
      ctx.scale ratio, ratio

  resizeCanvas = ->
    min = Math.min $(window).width(), $(window).height()
    canvas.width = min - 30
    canvas.height = min - 30
    fixDeviceScaling()
    drawSongCanvas()


  Template.user_music_grid.rendered = ->
    canvas = $('canvas')[0]

    resizeCanvas()
    $(window).resize ->
      resizeCanvas()

    drawSongCanvas()

  updateMusicPosition = (e) ->
    user = User.findOne userId
    mousePos = getCanvasMousePosition e
    mousePos.x *= ratio
    mousePos.y *= ratio
    user.musicPosition = mousePos
    User.update user._id, user
    drawSongCanvas()

  mouseDown = false
  Template.user_music_grid.events
    'mousedown canvas': (e) ->
      mouseDown = true
      updateMusicPosition e

    'mousemove canvas': (e) ->
      if mouseDown
        updateMusicPosition e

    'mouseup canvas': (e) ->
      mouseDown = false


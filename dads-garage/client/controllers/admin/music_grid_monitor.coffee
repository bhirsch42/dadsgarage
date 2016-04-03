if Meteor.isClient
  activeSong = null
  mouseDown = false
  canvas = null
  average = null

  CanvasUtils = {
    drawCircle: (ctx, x, y, r) ->
      ctx.beginPath()
      ctx.arc x, y, r, 0, 2 * Math.PI
      ctx.stroke()

    drawNormCircle: (ctx, x, y, r) ->
      ctx.beginPath()
      ctx.arc x * ctx.canvas.width, y * ctx.canvas.height, r, 0, 2 * Math.PI
      ctx.stroke()

    clear: (ctx) ->
      ctx.clearRect 0, 0, ctx.canvas.width, ctx.canvas.height
  }

  dist = (a, b) ->
    x = a.x - b.x
    y = a.y - b.y
    return Math.sqrt x * x + y * y

  getCanvasMousePosition = (e) ->
    mx = e.clientX
    my = e.clientY
    rect = canvas.getBoundingClientRect()
    cx = rect.left
    cy = rect.top
    {x: (mx - cx) / canvas.width, y: (my - cy) / canvas.height}

  updateAverage = ->
    users = User.find {musicPosition: {$ne:null}}
    total = {x: 0.0, y: 0.0}
    users.forEach (user) ->
      total.x += user.musicPosition.x
      total.y += user.musicPosition.y
    total.x /= users.count()
    total.y /= users.count()
    average = total

  updateMusic = _.throttle ->
    songs = Song.find {position: {$ne:null}}
    closestSong = null
    songs.forEach (song) ->
      if not closestSong or dist(song.position, average) < dist(closestSong.position, average)
        closestSong = song
    if not activeSong or closestSong._id != activeSong._id
      console.log 'played grid music'
      activeSong = closestSong
      MyMusic.fadeTime = 3000
      MyMusic.playOnly activeSong
  , 5000

  drawSongCanvas = ->
    songs = Song.find {position: {$ne:null}}
    users = User.find {musicPosition: {$ne:null}}

    w = canvas.width
    h = canvas.height
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

    ctx.strokeStyle = '#01baef'
    users.forEach (user) ->
      CanvasUtils.drawNormCircle ctx, user.musicPosition.x, user.musicPosition.y, 2

    ctx.strokeStyle = '#d11149'
    if average
      CanvasUtils.drawNormCircle ctx, average.x, average.y, 2

    ctx.strokeStyle = '#000000'
    voronoi = new Voronoi()
    points = songs.map (s) -> return s.position
    bbox = xl:0, xr:1, yt:0, yb:1
    v = voronoi.compute points, bbox

    ctx.beginPath()
    for edge in v.edges
      ctx.moveTo edge.va.x * ctx.canvas.width, edge.va.y * ctx.canvas.height
      ctx.lineTo edge.vb.x * ctx.canvas.width, edge.vb.y * ctx.canvas.height
    ctx.stroke()

  update = ->
    updateAverage()
    drawSongCanvas()
    updateMusic()


  Template.music_grid_monitor.rendered = ->
    canvas = @$('canvas')[0]
    update()

  Template.music_grid_monitor.created = ->
    User.find({musicPosition: {$ne:null}}).observe
      'added': ->
        if canvas
          update()
      'changed': ->
        if canvas
          update()

  Template.music_grid_monitor.events
    'click #clear-users': ->
      User.find({}).forEach (user) ->
        user.musicPosition = null
        User.update user._id, user
        drawSongCanvas()

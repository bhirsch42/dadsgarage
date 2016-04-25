if Meteor.isClient
  activeSong = null
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


  updateAverage = ->
    users = MusicPosition.find {}
    total = {x: 0.0, y: 0.0}
    users.forEach (user) ->
      total.x += user.x
      total.y += user.y
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

    w = canvas.width
    h = canvas.height
    ctx = canvas.getContext '2d'

    CanvasUtils.clear ctx

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

    MusicPosition.find({}).forEach (pos) ->
      $('#' + pos._id).css
        top  : (pos.y * @$('.user-music-grid').height()) + 'px'
        left : (pos.x * @$('.user-music-grid').width()) + 'px'
    $('#average').css
      top  : (average.y * @$('.user-music-grid').height()) + 'px'
      left : (average.x * @$('.user-music-grid').width()) + 'px'


  update = ->
    updateAverage()
    drawSongCanvas()
    updateMusic()


  Template.music_grid_monitor.rendered = ->
    canvas = @$('canvas')[0]
    update()

  Template.music_grid_monitor.created = ->
    MusicPosition.find({}).observe
      'added': ->
        if canvas
          update()
      'changed': ->
        if canvas
          update()

  Template.music_grid_monitor.events
    'click #clear-users': ->
      MusicPosition.find({}).forEach (pos) ->
        MusicPosition.remove pos._id

  Template.music_grid_monitor.helpers
    'position': ->
      MusicPosition.find {}

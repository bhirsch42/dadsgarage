if Meteor.isClient
  mySound = null
  mouseDown = false
  canvas = null

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

  getCanvasMousePosition = (e) ->
    mx = e.clientX
    my = e.clientY
    rect = canvas.getBoundingClientRect()
    cx = rect.left
    cy = rect.top
    {x: (mx - cx) / canvas.width, y: (my - cy) / canvas.height}

  getSelectedSong = ->
    $song = $('.selected')
    songName = $song.data 'name'
    Song.findOne name: songName

  drawSongCanvas = ->
    songs = Song.find {position: {$ne:null}}
    w = canvas.width
    h = canvas.height
    ctx = canvas.getContext '2d'

    selectedSong = getSelectedSong()


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

    songs.forEach (song) ->
      if selectedSong and song._id == selectedSong._id
        ctx.strokeStyle = '#3fdd4d'
      CanvasUtils.drawNormCircle ctx, song.position.x, song.position.y, 2
      ctx.strokeStyle = '#000000'

    voronoi = new Voronoi()
    points = songs.map (s) -> return s.position
    bbox = xl:0, xr:1, yt:0, yb:1
    v = voronoi.compute points, bbox

    # for cell in v.cells
    #   ctx.beginPath()
    #   halfedge = cell.halfedges[0]
    #   ctx.moveTo halfedge.edge.lSite.x * ctx.canvas.width, halfedge.edge.lSite.y * ctx.canvas.height
    #   for halfedge in cell.halfedges[1..]
    #     ctx.lineTo halfedge.edge.lSite.x * ctx.canvas.width, halfedge.edge.lSite.y * ctx.canvas.height
    #     console.log halfedge.edge.lSite.x * ctx.canvas.width, halfedge.edge.lSite.y * ctx.canvas.height
    #   ctx.closePath()
    #   ctx.stroke()

    ctx.beginPath()
    for edge in v.edges
      ctx.moveTo edge.va.x * ctx.canvas.width, edge.va.y * ctx.canvas.height
      ctx.lineTo edge.vb.x * ctx.canvas.width, edge.vb.y * ctx.canvas.height
    ctx.stroke()

  Template.music_grid_builder.rendered = ->
    canvas = @$('canvas')[0]
    drawSongCanvas canvas

  dist = (a, b) ->
    x = a.x - b.x
    y = a.y - b.y
    return Math.sqrt x * x + y * y

  Template.music_grid_builder.events
    'mousedown canvas': (e) ->
      mouseDown = true
      mousePos = getCanvasMousePosition e

      songs = Song.find {position: {$ne:null}}, {sort: {name: 1}}

      songs.forEach (song) ->
        if dist(song.position, mousePos) < .01
          console.log song
          $('.selected').removeClass 'selected'
          $('.song').each (i, s) ->
            $s = $(s)
            if $s.data('name') == song.name
              console.log $s
              $s.addClass 'selected'
              $('.song-list').scrollTop 0
              $('.song-list').scrollTop $('.selected').offset().top - $('.song-list').offset().top
              drawSongCanvas()
              return

      song = getSelectedSong()
      if not song.position
        song.position = mousePos
        Song.update song._id, song
        drawSongCanvas()


    'mouseup canvas': (e) ->
      mouseDown = false

    'mousemove canvas': (e) ->
      if mouseDown
        mousePos = getCanvasMousePosition e
        song = getSelectedSong()
        song.position = mousePos
        Song.update song._id, song
        drawSongCanvas()


    'click .song': (e) -> # TODO: Solve the 'pending' problem
      MyMusic.stopAllMusic()

      $('.song.selected').removeClass 'selected'
      $song = $(e.target).closest '.song'
      $song.addClass 'selected'

      song = getSelectedSong()

      MyMusic.playMusic song

      drawSongCanvas()

    'click #play': (e) ->
      MyMusic.playOnly getSelectedSong()

    'click #stop': (e) ->
      MyMusic.stopAllMusic()

    'click #pause': (e) ->
      MyMusic.stopAllMusic()

    'click #remove': (e) ->
      song = getSelectedSong()
      song.position = null
      Song.update song._id, song
      drawSongCanvas()


  Template.music_grid_builder.helpers
    'songs': ->
      Song.find {}

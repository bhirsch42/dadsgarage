if Meteor.isClient
  @MyMusic = {}

  MyMusic.initializedSongs = []

  MyMusic.playingSongs = []

  MyMusic.addedFileloadListener = false

  MyMusic.fadeTime = 3000

  MyMusic.initSong = (song) ->
    # songUrl = 'http://localhost:5757/' + $(e.target).closest('.song').find('.song-name').html()
    # songUrl = 'https://s3.amazonaws.com/dads-garage-music/' + $(e.target).closest('.song').find('.song-name').html()
    createjs.Sound.registerSound
      src: 'https://s3.amazonaws.com/dads-garage-music/' + song.name
      id: song.name

  MyMusic.isPlaying = (song) ->
    return MyMusic.playingSongs.indexOf(song) != -1

  MyMusic.playMusic = (song) ->
    if song.name not in MyMusic.initializedSongs
      MyMusic.initializedSongs.push song.name
      MyMusic.initSong song
      return
    if not MyMusic.isPlaying song
      MyMusic.playingSongs.push song
      SM.playMusic song.name, 0, MyMusic.fadeTime

  MyMusic.handleLoadComplete = (event) ->
    MyMusic.playMusic Song.findOne name: event.id

  MyMusic.stopMusic = (song) ->
    if MyMusic.isPlaying song
      MyMusic.playingSongs.splice MyMusic.playingSongs.indexOf(song), 1
      SM.stopMusic song.name, MyMusic.fadeTime

  MyMusic.toggleMusic = (song) ->
    if not MyMusic.isPlaying song
      MyMusic.playMusic song
    else
      MyMusic.stopMusic song

  MyMusic.stopAllMusic = ->
    MyMusic.playingSongs = []
    SM.stopAllMusics MyMusic.fadeTime

  MyMusic.playOnly = (song) ->
    if MyMusic.isPlaying song
      MyMusic.stopAllMusic()
    else
      MyMusic.stopAllMusic()
      MyMusic.playMusic song

  if not MyMusic.addedFileloadListener
    createjs.Sound.addEventListener 'fileload', MyMusic.handleLoadComplete
    MyMusic.addedFileloadListener = true

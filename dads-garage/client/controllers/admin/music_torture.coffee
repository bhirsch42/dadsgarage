if Meteor.isClient

  songName1 = 'Michael+Pollock+-+Rock+Ballad+Accompaniment.mp3'
  songName2 = 'Atmosphere+-+Yesterday+(Instrumental+Looped).mp3'

  songName = songName1

  Template.admin_music_torture.events
    'click .show': ->
      SimpleVote.add 2
      ActivePage.set 'music_torture'

    'click #ballad': ->
      songName = songName1

    'click #rap': ->
      songName = songName2

  Template.admin_music_torture.helpers
    'votes': ->
      results = SimpleVote.results()
      if results['1'] > results['2']
        song = Song.findOne name: songName
        console.log 'play music'
        MyMusic.playMusic song
      else
        console.log 'stop playing music'
        MyMusic.stopAllMusic()
      results['1']

  Template.admin_music_torture.created = ->
    song1 = Song.findOne name: songName1
    if not song1
      Song.add songName1
      song1 = Song.findOne name: songName1
    MyMusic.initSong Song.findOne name: songName1

    song2 = Song.findOne name: songName2
    if not song2
      Song.add songName2
      song2 = Song.findOne name: songName2
    MyMusic.initSong Song.findOne name: songName2


  Template.admin_music_torture.rendered = ->
    MyMusic.fadeTime = 0
    MyMusic.stopAllMusic()

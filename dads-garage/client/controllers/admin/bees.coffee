if Meteor.isClient

  songName1 = 'sounds/bees.mp3'

  songName = songName1

  Template.admin_bees.events
    'click .show': ->
      SimpleVote.add 2
      ActivePage.set 'bees'

    'click #ballad': ->
      songName = songName1

    'click #rap': ->
      songName = songName2

  Template.admin_bees.helpers
    'votes': ->
      results = SimpleVote.results()
      yesFrac = 1.0 * results['1'] / (results[1] + results[2])
      if yesFrac > .5
        song = Song.findOne name: songName
        console.log 'play music'
        MyMusic.playMusic song
      if yesFrac < .3
        console.log 'stop playing music'
        MyMusic.stopAllMusic()
      results['1']

  Template.admin_bees.created = ->
    song1 = Song.findOne name: songName1
    if not song1
      Song.add songName1
      song1 = Song.findOne name: songName1
    MyMusic.initSong Song.findOne name: songName1


  Template.admin_bees.rendered = ->
    MyMusic.fadeTime = 0
    MyMusic.stopAllMusic()

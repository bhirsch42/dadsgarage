if Meteor.isClient

  songName = 'Michael+Pollock+-+Rock+Ballad+Accompaniment.mp3'

  Template.admin_music_torture.events
    'click .show': ->
      SimpleVote.add 2
      ActivePage.set 'music_torture'

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
    song = Song.findOne name: songName
    if not song
      Song.add songName
      song = Song.findOne name: songName
    MyMusic.initSong Song.findOne name: songName

  Template.admin_music_torture.rendered = ->
    MyMusic.fadeTime = 0
    MyMusic.stopAllMusic()

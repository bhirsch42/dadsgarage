if Meteor.isClient

  Template.stage_music_torture.helpers
    'update': ->
      console.log 'update'
      results = SimpleVote.results()
      frac = results['1'] / (results['1'] + results['2'])
      size = frac * (60 - 25) * 2 + 25
      size = size + 'vh'
      $('.circle-meter').css(height: size, width: size);
      if frac > .5
        $('.fa-music').addClass 'music-on'
      else
        $('.fa-music').removeClass 'music-on'
      results['1']


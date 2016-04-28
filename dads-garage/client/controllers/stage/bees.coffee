if Meteor.isClient

  Template.stage_bees.helpers
    'update': ->
      console.log 'update'
      results = SimpleVote.results()
      frac = results['1'] / (results['1'] + results['2'])
      size = frac * (60 - 25) * 2 + 25
      size = size + 'vh'
      $('.circle-meter').css(height: size, width: size);
      if frac > .5
        $('.stage-music-torture').addClass 'active'
        $('.fa-music').addClass 'music-on'
      else
        $('.stage-music-torture').removeClass 'active'
        $('.fa-music').removeClass 'music-on'
      results['1']

    'range': ->
      [1..200]

  Template.stage_bees.rendered = ->
    $('.bee-wrapper').each (i, o) ->
      $(o).css
        'top': (Math.random() * 200 - 50) + 'vh'
        'left' : (Math.random() * 200 - 50) + 'vw'
        'animation': 'rotating ' + Math.random() * 5 + 2 + 's linear infinite'

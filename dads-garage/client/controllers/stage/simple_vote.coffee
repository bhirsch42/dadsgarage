if Meteor.isClient
  update = ->
    results = SimpleVote.results()
    max = _.max _.values results
    _.map results, (val, key) ->
      $('#' + key).css 'height', (val / max * 80) + '%'

  Template.stage_simple_vote.helpers
    'results': ->
      update()
      {key: result[0], val: result[1]} for result in _.pairs SimpleVote.results()

    'done': ->
      if SimpleVote.get().isOver
        results = ({key: result[0], val: result[1]} for result in _.pairs SimpleVote.results())
        console.log results
        maxKey = results[0].key
        maxVal = 0
        for result in results
          if result.val > maxVal
            maxVal = result.val
            maxKey = result.key
        $('.stage-simple-vote').empty()
        $('.stage-simple-vote').append('<div id=\'done\'>' + maxKey + '</div>')
      else
        $('#done').remove()

  # Template.stage_simple_vote.rendered = ->
  #   SimpleVote.find({}).observe
  #     'changed': ->
  #       console.log 'changed'
  #       if SimpleVote.get().isOver
  #         $('.stage-simple-vote').empty()
  #         Blaze.render Template.stage_simple_vote_done, $('.stage-simple-vote')[0]


  # Template.stage_simple_vote_done.helpers
  #   'result': ->
  #     results = ({key: result[0], val: result[1]} for result in _.pairs SimpleVote.results())
  #     console.log results
  #     maxKey = results[0].key
  #     maxVal = 0
  #     for result in results
  #       if result.val > maxVal
  #         maxVal = result.val
  #         maxKey = result.key
  #     maxKey


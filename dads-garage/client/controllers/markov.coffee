if Meteor.isClient
  Template.markov.events
    'click #submit': ->
      o = JSON.parse $('#json-input').val()
      if o
        MarkovOutput.find({}).forEach (m) ->
          MarkovOutput.remove m._id
      for m in o
        MarkovOutput.insert m

  Template.markov.helpers
    'outputs': ->
      MarkovOutput.find({})

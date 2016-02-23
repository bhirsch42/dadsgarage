@ActivePage = new Mongo.Collection 'activePage'

@ActivePage.set = (template) ->
  ActivePage.insert template: template, time: Date.now()

@ActivePage.get = ->
  activePage = ActivePage.findOne({}, {sort: {time: -1, limit: 1}})
  return activePage

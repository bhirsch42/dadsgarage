if Meteor.isServer
  ActivePage.remove {}
  ActivePage.set 'home'

if Meteor.isClient

  Template.admin.events
    'click button': (e) ->
      name = $(e.target).data 'name'
      console.log name
      ActivePage.set name


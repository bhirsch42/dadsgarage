if Meteor.isClient
  Template.admin_music_grid.events
    'click .button.show': ->
      ActivePage.set 'music_grid'

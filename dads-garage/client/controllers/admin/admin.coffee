if Meteor.isClient

  Template.admin_nav.helpers
    'pages': ->
      ps = [
      # ['template_name', 'Name that shows in Admin Panel']
        ['home', 'Home']
        ['questions', 'Questions']
        ['simple_vote', 'Simple Vote']
        ['music_grid', 'Music Grid']
        ['bees', 'Bees']
        ['music_torture', 'Music Torture']
        ['roulette', 'Roulette']
      ]
      return ({templateName: p[0], adminDisplay: p[1]} for p in ps)


  Template.admin.events
    'click .nav-item': (e) ->
      $navItem = $(e.target)
      $('.nav-item').removeClass('active')
      $navItem.addClass 'active'
      name = $navItem.data 'name'
      $content = $('.admin').find('#content')
      $content.empty()
      Blaze.render Template['admin_' + name], $content[0]

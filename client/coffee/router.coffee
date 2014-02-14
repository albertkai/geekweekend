Router.configure
  layoutTemplate: 'layout'

Router.map ()->

  @route 'home', {
    path: '/'
  }

  @route 'about', {
  }

  @route 'courses', {
  }

  @route 'course', {
    path: 'course/:alias/:event'
    before: ->
      console.log Courses.find({alias: @params.alias})
    data: ->
      {
        course: Courses.findOne({alias: @params.alias})
        event: @params.event
      }
  }

  @route 'contacts', {
  }

  @route 'dashboard', {
    before: ->
      loggedInUser = Meteor.user()
      if !loggedInUser or !Roles.userIsInRole loggedInUser, ['admin']
        $.jGrowl('У вас нет прав для доступа, пожалуйста залогинтесь!')
        @stop()
        Router.go('home')

  }
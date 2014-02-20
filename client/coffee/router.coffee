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
      Session.set 'currentEvent', @params.event
    data: ->
      {
        course: Courses.findOne({alias: @params.alias})
        event: @params.event
      }
  }

  @route 'createCourse', {
    before: ->
      loggedInUser = Meteor.user()
      if !loggedInUser or !Roles.userIsInRole loggedInUser, ['admin']
        $.jGrowl('У вас нет прав для доступа, пожалуйста залогинтесь!')
        @stop()
        Router.go('home')
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
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
    path: 'course/:alias'
    before: ->
      console.log Courses.find({alias: @params.alias})
    data: ->
      Courses.findOne({alias: @params.alias})
  }

  @route 'contacts', {
  }
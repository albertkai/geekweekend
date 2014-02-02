Template.home.helpers {
  courses: ->
    Courses.find({pop: true}, {limit: 6})
}
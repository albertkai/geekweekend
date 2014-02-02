Template.course.rendered = ->
  $('#course-pic').scrolly({bgParallax: true})
  $('#course-pic h1').attr('data-stellar-ratio', .7)
  $('#course-pic h2').attr('data-stellar-ratio', .8)
  $('#course-pic h3').scrolly()

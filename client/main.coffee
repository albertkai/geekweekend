Session.set 'city', 'msk'
Session.set 'Slider.currentSlide', 0
Session.set 'coursesFilter.chooseSphere', 'webdev'
Session.set 'coursesFilter.chooseSort', 'date'


Meteor.startup ->
  $.ionSound({
    sounds: [
      "glass"
    ],
    path: "/sounds/"
  })



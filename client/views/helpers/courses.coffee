Template.courses.rendered = ->
  $('.isotope').isotope {
    itemSelector: '.item'
  }


Template.courses.helpers {
  courses: ->
    Courses.find {}
}

Template.courses.events {
  'mouseenter .courses-cont .item': (e)->
    $(e.target).closest('.item').find('.wrapper').addClass('flipIt')
  'mouseleave .courses-cont .item': (e)->
    $(e.target).closest('.item').find('.wrapper').removeClass('flipIt')
}
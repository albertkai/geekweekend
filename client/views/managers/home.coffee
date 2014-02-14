Template.home.rendered = ->
  $('body').imagesLoaded ->
    Slider.init()
    console.log 'imagesLoaded'

Template.home.helpers {
  events: ->
    Events.find({pop: true}, {limit: 6})
}


Template.home.events {
  'click #slider #slider-arrows .arrow-left': ->
    Slider.changeSlide('left')
  'click #slider #slider-arrows .arrow-right': ->
    Slider.changeSlide('right')
  'click #slider-controls ul li': (e)->
    num = $(e.target).closest('li').index()
    Session.set 'Slider.currentSlide', num
  'click #top-courses>div': (e)->
    target = $(e.target).closest('.item').data('alias')
    Router.go('course', {alias: target})
}


Template.popCourseItem.helpers {

  getDate: (date)->
    "#{moment(date).lang('ru').format('D')} - #{moment(date).lang('ru').add('days', 1).format('D MMMM')}"

  course: ->
    Courses.findOne({alias: @course})

  getType: (type)->
    if type is 1
      'kick-start'
    else if type is 2
      'level-up'
    else if type is 3
      'pro'
}


@Slider = {

  init: ()->
    console.log 'Slider initialized'
    @setMeasures()
    $(window).resize ->
      Slider.init()

  setMeasures: ()->
    slideWidth = $(window).width()
    contWidth = slideWidth * $('#slider>ul li').length + 10
    $('#slider > ul').width(contWidth)
    $('#slider > ul li').width(slideWidth)
    $('#slider > ul li .animating').addClass('_animated')
    Deps.autorun ->
      currentSlide = Session.get('Slider.currentSlide')
      $('#slider ul li').find('.animating').removeClass('_animated')
      $('#slider > ul').css('left', -(currentSlide * slideWidth) + 'px')
      $('#slider-controls ul li').removeClass('_active')
      $('#slider-info ul li').removeClass('_active')
      $('#slider-controls ul li').eq(Session.get('Slider.currentSlide')).addClass('_active')
      $('#slider-info ul li').eq(Session.get('Slider.currentSlide')).addClass('_active')
      setTimeout ->
        $('#slider ul li').eq(currentSlide).find('.animating').addClass('_animated')
      , 400

  changeSlide: (dir)->
    if dir is 'left'
      currentSlide = Session.get 'Slider.currentSlide'
      if currentSlide isnt 0
        newSlide = currentSlide - 1
      else
        newSlide = $('#slider > ul li').length - 1
      Session.set 'Slider.currentSlide', newSlide
      console.log Session.get 'Slider.currentSlide'
    else if dir is 'right'
      currentSlide = Session.get 'Slider.currentSlide'
      if currentSlide < $('#slider > ul li').length - 1
        newSlide = currentSlide + 1
      else
        newSlide = 0
      Session.set 'Slider.currentSlide', newSlide
      console.log Session.get 'Slider.currentSlide'
}
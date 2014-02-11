Template.course.rendered = ->
  $('#get-course').waypoint ->
    console.log 'yo'
  , {offset: 400}


Template.course.helpers {
  trainer: ->
    Trainers.findOne({id: @trainer})
  getType: ->
    if @type is 1
      'kick-start'
    else if @type is 2
      'level-up'
    else if @type is 3
      'pro'
  city: ->
    Cities.findOne({alias: Session.get('city')})
}

Template.course.events {
  'click #get-course': ->
    $('.modal-overlay').addClass('_opened')
    $('#get-course-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')
}

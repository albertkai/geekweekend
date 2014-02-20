Template.course.rendered = ->
  $('#get-course').waypoint ->
    console.log 'yo'
  , {offset: 400}


Template.course.helpers {
  trainer: ->
    Trainers.findOne({id: @trainer})
  getType: (type)->
    if @type is 1
      'kick-start'
    else if @type is 2
      'level-up'
    else if @type is 3
      'pro'
  city: ->
    Cities.findOne({alias: Session.get('city')})

  date: ->
    date = Events.findOne({id: parseInt(Session.get 'currentEvent', 10)}).date
    "#{moment(date).format('D')} - #{moment(date).lang('ru').add('days', 1).format('D MMMM')}"

}

Template.course.events {
  'click #get-course': ->
    $('.modal-overlay').addClass('_opened')
    $('#get-course-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  'click #get-course-modal .further': (e)->
    e.preventDefault()
    slideStep = 556
    if $('#first-form').valid()
      $('#get-course-modal').find('.body').css('left', -slideStep + 'px')

  'click .go': (e)->
    e.preventDefault();

  'mouseenter .custom-select': (e)->
    $(e.target).closest('.custom-select').find('ul').addClass('_visible')

  'mouseleave .custom-select': (e)->
    $(e.target).closest('.custom-select').find('ul').removeClass('_visible')

  'click .custom-select>ul>li': (e)->
    $(e.target).closest('ul').find('li').removeClass('_active')
    $(e.target).closest('li').addClass('_active')
    $(e.target).closest('ul').removeClass('_visible')
    data = $(e.target).closest('li').data('value')
    text = $(e.target).closest('li').html()
    $(e.target).closest('.custom-select').find('p').text(text)
    $(e.target).closest('.custom-select').find('.value').val(data)

  'click .go': (e)->
    e.preventDefault()
    orderFormCtrl.sendOrder()

}


orderFormCtrl = {

  sendOrder: ->
    order = []
    order.push {name: 'name', value: $('#first-form').find('#first-name').val()}
    order.push {name: 'secondName', value: $('#first-form').find('#second-name').val()}
    order.push {name: 'tel', value: $('#first-form').find('#tel').val()}
    order.push {name: 'email', value: $('#first-form').find('#email').val()}
    order.push {name: 'event', value: $('#event').val()}
    order.push {name: 'title', value: $('#courseTitle').val()}
    order.push {name: 'date', value: $('#courseDate').val()}
    order.push {name: 'additional', value: $('#additional').val()}
    order.push {name: 'needLaptop', value: $('#got-notebook').find('.value').val()}
    order.push {name: 'system', value: $('#system').find('.value').val()}
    order.push {name: 'payment', value: $('#second-form').find('[name="payment"]:checked').val()}
    order.push {name: 'city', value: $('#city').val()}
    order.push {name: 'status', value: 'new'}
    Meteor.call 'createOrder', order, (error, result)->
      if error
        $.jGrowl('Что-то пошло не так=( Свяжитесь пожалуйста с нами по телефону!')
      else
        if result
          $.jGrowl("Ваша заявка принята, #{$('#first-form').find('#first-name').val()}! Мы с вами свяжемся, действительно очень быстро=)")
        else
          $.jGrowl('Что-то пошло не так=( Свяжитесь пожалуйста с нами по телефону!')
      $('.r-modal').removeClass('flipInY').addClass('flipOutY')
      $('.modal-overlay').removeClass('_opened')
      setTimeout ->
        $('.r-modal').css('visibility', 'hidden')
      , 500

}
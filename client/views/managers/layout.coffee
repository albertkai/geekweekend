Template.layout.events {

  'click .modal-overlay': ->
    $('.r-modal').removeClass('flipInY').addClass('flipOutY')
    $('.modal-overlay').removeClass('_opened')
    setTimeout ->
      $('.r-modal').css('visibility', 'hidden')
    , 500

  'click .r-modal .close': ->
    $('.r-modal').removeClass('flipInY').addClass('flipOutY')
    $('.modal-overlay').removeClass('_opened')
    setTimeout ->
      $('.r-modal').css('visibility', 'hidden')
    , 500

  'change #file-upload input': (e)->

    reader = new FileReader()
    resreader = new FileReader()
    file = e.srcElement.files[0]

    resize = ()->
      deferred = $.Deferred()
      $.canvasResize(file, {
        width: 300,
        height: 0,
        crop: false,
        quality: 80,
        callback: (data, width, height)->
          deferred.resolve(data)
          console.log {data: data}
        })
      deferred.promise()


    originalFile = ()->
      deferred = $.Deferred()
      reader.readAsBinaryString(file)
      reader.onload = (e)->
        ifile = reader.result
        deferred.resolve(ifile)
        console.log {reader: ifile}
      deferred.promise()

    $.when(originalFile(), resize()).done (ifile, resizedFile)->
      Meteor.call 'upload', file, ifile, resizedFile



  'click .collab-link': (e)->
    e.preventDefault();
    $('.modal-overlay').addClass('_opened')
    $('#collab-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  'click #admin-login-modal .close': ->
    $('#admin-login-modal').removeClass('flipInY').addClass('flipOutY')
    setTimeout ->
      $('#admin-login-modal').css('visibility', 'hidden')
    , 500

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

  'click #collab-modal .go': (e)->
    e.preventDefault()
    request = []
    request.push {name: 'theme', value: $('#collab-form').find('#collab-theme').val()}
    request.push {name: 'text', value: $('#collab-form').find('#collab-text').val()}
    request.push {name: 'name', value: $('#collab-form').find('#collab-first-name').val()}
    request.push {name: 'secondName', value: $('#collab-form').find('#collab-second-name').val()}
    request.push {name: 'tel', value: $('#collab-form').find('#collab-tel').val()}
    request.push {name: 'email', value: $('#collab-form').find('#collab-email').val()}
    request.push {name: 'city', value: $('#collab-city').find('.value').val()}
    request.push {name: 'status', value: 'new'}
    Meteor.call 'createRequest', request, (error, result)->
      if error
        $.jGrowl('Что-то пошло не так=( Свяжитесь пожалуйста с нами по телефону!')
      else
        if result
          $.jGrowl("Ваша заявка принята, #{$('#collab-form').find('#collab-first-name').val()}! Мы с вами свяжемся, действительно очень быстро=)")
        else
          $.jGrowl('Что-то пошло не так=( Свяжитесь пожалуйста с нами по телефону!')
      $('.r-modal').removeClass('flipInY').addClass('flipOutY')
      $('.modal-overlay').removeClass('_opened')
      setTimeout ->
        $('.r-modal').css('visibility', 'hidden')
      , 500
}

Template.layout.rendered = ->

  Mousetrap.bind 'command+shift+a', (e)->
    showAdminModal()

  Mousetrap.bind 'ctrl+shift+a', (e)->
    showAdminModal()

showAdminModal = ->
  $('#admin-login-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

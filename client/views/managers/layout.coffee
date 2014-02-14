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

  'click .collab-link': (e)->
    e.preventDefault();
    $('.modal-overlay').addClass('_opened')
    $('#collab-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  'click #admin-login-modal .close': ->
    $('#admin-login-modal').removeClass('flipInY').addClass('flipOutY')
    setTimeout ->
      $('#admin-login-modal').css('visibility', 'hidden')
    , 500
}

Template.layout.rendered = ->

  Mousetrap.bind 'command+shift+a', (e)->
    showAdminModal()

  Mousetrap.bind 'ctrl+shift+a', (e)->
    showAdminModal()

showAdminModal = ->
  $('#admin-login-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

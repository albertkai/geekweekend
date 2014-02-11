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
}
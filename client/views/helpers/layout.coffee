Template.layout.events {
  'click .modal-overlay': ->
    $('.r-modal').removeClass('flipInY').addClass('flipOutY')
    $('.modal-overlay').removeClass('_opened')
    setTimeout ->
      $('.r-modal').css('visibility', 'hidden')
    , 500
}
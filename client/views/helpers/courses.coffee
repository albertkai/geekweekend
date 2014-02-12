Template.courses.rendered = ->

  Deps.autorun ->
    $('.isotope').isotope {
      itemSelector: '.item'
    }

  $('#chooseCity').find('[data-city="' + Session.get('city') + '"]').addClass('_active')



Template.courses.helpers {

  events: ->
    options = {}
    sorting = {}
    if Session.get('coursesFilter.chooseSphere') isnt '*'
      options['sphere'] = Session.get('coursesFilter.chooseSphere')
    sorting[Session.get('coursesFilter.chooseSort')] = 1
    Events.find({city: Session.get('city')}, {sort: sorting})

}

Template.courseItem.helpers {

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

Template.courses.events {

  'mouseenter .courses-cont .item': (e)->
    $(e.target).closest('.item').find('.wrapper').addClass('flipIt')

  'mouseleave .courses-cont .item': (e)->
    $(e.target).closest('.item').find('.wrapper').removeClass('flipIt')

  'click .courses-cont .item': (e)->
    target = $(e.target).closest('.item').data('alias')
    Router.go('course', {alias: target})

  'click .multi-select>ul>li': (e)->
    $(e.target).closest('ul').find('li').removeClass('_active')
    $(e.target).closest('li').addClass('_active')
    Session.set 'city', $(e.target).closest('li').data('city')

  'mouseenter .custom-select': (e)->
    $(e.target).closest('.custom-select').find('ul').addClass('_visible')

  'mouseleave .custom-select': (e)->
    $(e.target).closest('.custom-select').find('ul').removeClass('_visible')

  'click .custom-select>ul>li': (e)->
    $(e.target).closest('ul').find('li').removeClass('_active')
    $(e.target).closest('li').addClass('_active')
    $(e.target).closest('ul').removeClass('_visible')
    name = $(e.target).closest('.custom-select').attr('id')
    data = $(e.target).closest('li').data('value')
    text = $(e.target).closest('li').html()
    $(e.target).closest('.custom-select').find('p').text(text)
    Session.set('coursesFilter.' + name, data)

  'click .custom-checkbox': (e)->
    target = $(e.target).closest('.custom-checkbox')
    allActive = $(e.target).closest('#chooseType').find('.custom-checkbox._active')
    if allActive.length is 1 and target.hasClass('_active')
      return
    else
      target.toggleClass('_active')
      string = ''
      $(e.target).closest('#chooseType').find('.custom-checkbox._active').each ->
        string += '.' + $(this).data('value') + ', '
      string = string.substring(0, string.length - 2)
      Session.set 'courseFilter.filter', string
      console.log string
      $('.isotope').isotope {
        itemSelector: '.item'
        filter: string
      }


}
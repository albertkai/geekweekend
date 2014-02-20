Template.dashboard.helpers {

  orders: ->
    Orders.find({})

  requests: ->
    Requests.find({})

  subscribers: ->
    Subscribers.find({})

  showStatus: (status)->
    switch status
      when 'new' then ''
      when 'hot' then 'warning'
      when 'processed' then 'success'

  newOrders: ->
    Orders.find({status: 'new'}).count()

  hotOrders: ->
    Orders.find({status: 'hot'}).count()

  newRequests: ->
    Requests.find({status: 'new'}).count()

  allSubscribers: ->
    Subscribers.find({}).count()

}


Template.dashboard.events {

  'click #orders-table tbody tr td': (e)->
    id = $(e.target).closest('tr').data('id')
    data = Orders.findOne {_id: id}
    html = Meteor.render ->Template.orderModal {order: data}
    $('.dashboard-edit-modal').html(html)
    $('.dashboard-edit-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

  'click #requests-table tbody tr td': (e)->
    id = $(e.target).closest('tr').data('id')
    data = Requests.findOne {_id: id}
    html = Meteor.render ->Template.requestModal {request: data}
    $('.dashboard-edit-modal').html(html)
    $('.dashboard-edit-modal').css('visibility', 'visible').removeClass('flipOutY').addClass('animated flipInY')

}

Template.orderModal.events {
  'click .controls .recall': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    Meteor.call 'updateOrder', id, 'recall', (err, res)->
      DashboardCtrl.informUpdate(res)
      DashboardCtrl.closeModal()
      DashboardCtrl.sendEmail()

  'click .controls .done': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    Meteor.call 'updateOrder', id, 'done', (err, res)->
      DashboardCtrl.informUpdate(res)
      DashboardCtrl.closeModal()
      options = {
        from:"sender@domain.com"
        to:"albertkai@me.com"
        subject:"I want to share this with you =)"
        html: ->Template.newOrderEmail()
      }
      DashboardCtrl.sendEmail(options)

  'click .controls .delete': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    Meteor.call 'deleteOrder', id, (err, res)->
      DashboardCtrl.informDelete(res)
      DashboardCtrl.closeModal()

}


Template.requestModal.events {

  'click .controls .recall': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    console.log id
    Meteor.call 'updateRequest', id, 'recall', (err, res)->
      DashboardCtrl.informUpdate(res)
      DashboardCtrl.closeModal()

  'click .controls .done': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    Meteor.call 'updateRequest', id, 'done', (err, res)->
      DashboardCtrl.informUpdate(res)
      DashboardCtrl.closeModal()

  'click .controls .delete': (e)->
    id = $(e.target).closest('.controls').siblings('.header').data('id')
    Meteor.call 'deleteRequest', id, (err, res)->
      DashboardCtrl.informDelete(res)
      DashboardCtrl.closeModal()


}


Template.orderModal.helpers {

  hasAdditional: (add)->
    if add is ''
      false
    else
      true
}


DashboardCtrl = {
  closeModal: ->
    $('.r-modal').removeClass('flipInY').addClass('flipOutY')
    $('.modal-overlay').removeClass('_opened')
    setTimeout ->
      $('.r-modal').css('visibility', 'hidden')
    , 500

  informUpdate: (res)->
    if res
      $.jGrowl('Статус заказа обновлен!')
    else
      $.jGrowl('Че-то какая-то хуйня=( Сообщи айтишникам!')
    $.ionSound.play("glass")

  informDelete: (res)->
    if res
      $.jGrowl('Заказ удален=(')
    else
      $.jGrowl('Че-то какая-то хуйня=( Сообщи айтишникам!')
    $.ionSound.play("glass")

  sendEmail: (options)->
    Meteor.call 'emailSend', options
}

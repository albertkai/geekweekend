

Meteor.methods {

  createOrder: (order)->
    future = new Future()
    Regulate.sendOrder.validate order, (error, data)->
      if error
        console.log error
        future.return false
      else
        newOrder = {}
        for obj in data
          newOrder[obj.name] = obj.value
        Orders.insert newOrder
        future.return true

    return future.wait()

  updateOrder: (id, order)->
    console.log 'update Order:/n'
    console.log id
    console.log order

  deleteOrder: (id)->

}


ordersCtrl = {


  checkRole: (roles)->

    if !Meteor.user()
      return false
    user = Meteor.user()
    if !Roles.userIsInRole user, roles
      return false
    else
      return true
}
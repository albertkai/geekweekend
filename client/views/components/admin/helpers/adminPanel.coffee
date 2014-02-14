Template.adminPanel.events {
  'click .invoke': ->
    Meteor.call 'createOrder', {order: 'new'}
}
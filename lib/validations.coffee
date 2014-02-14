Regulate 'sendOrder', [
  {
    name: 'name',
    min_length: 1,
    max_length: 80
  }, {
    name: 'secondName',
    min_length: 1,
    max_length: 12
  }, {
    name: 'tel',
    min_length: 5,
    max_length: 20
  }, {
    name: 'email',
    email: true
  }, {
    name: 'event',
    max_length: 50
  }, {
    name: 'needLaptop',
    max_length: 50
  }, {
    name: 'system',
    max_length: 50
  }, {
    name: 'payment',
    max_length: 50
  }

]
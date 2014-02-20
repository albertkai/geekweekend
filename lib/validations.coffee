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
  }, {
    name: 'title',
    max_length: 100
  }, {
    name: 'date',
    max_length: 100
  }, {
    name: 'city',
    max_length: 100
  }

]

Regulate 'sendRequest', [

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
    name: 'city',
    max_length: 50
  }, {
    name: 'theme',
    max_length: 50
  }, {
    name: 'text',
    max_length: 1000
  }

]


Regulate 'subscribe', [

  {
    name: 'email',
    email: true
  }

]
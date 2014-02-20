if Courses.find({}).count() is 0
  Courses.insert {
    alias: 'html5'
    sphere: 'webdev'
    title: 'html5 + css3'
    type: _.random(1, 3)
    shortDesc: 'Основы веб-разработки'
    desc: 'Данный курс - лучшее, что может предложить индустрия на данный момент! Вы пройдете как и базовые, так и другие темы'
    pic: 'htmll.png'
    price: 3000
    schedule: {
      saturday: '<div><p>12:00</p><p>Встречаемся и разговариваем по душам!</p></div><div><p>13:00</p><p>Встречаемся и разговариваем по душам!</p></div><div><p>15:00</p><p>Встречаемся и разговариваем по душам!</p></div>',
      sunday: '<div><p>12:00</p><p>Встречаемся и разговариваем по душам!</p></div><div><p>13:00</p><p>Встречаемся и разговариваем по душам!</p></div><div><p>15:00</p><p>Встречаемся и разговариваем по душам!</p></div>'
    }
    trainer: 1
    skills: '<ul><li>Пункт1</li><li>Пункт2</li></ul>'
    topics: '<ul><li>Пункт1</li><li>Пункт2</li></ul>'
    require: '<ul><li>Пункт1</li><li>Пункт2</li></ul>'
  }

if Trainers.find({}).count() < 5
  Trainers.insert {
    id: 1
    name: 'Альберт'
    secondName: 'Кайгородов'
    skills: ['HTML5', 'CSS3', 'JS/JQUERY', 'UI/UX', 'NODE.JS', 'BACKBONE.JS', 'METEOR.JS']
    about: 'Занимется веб-разработкой с 2007 года, является frontend-разработчиком высшего класса. Сотрудничал с такими компаниями как Газпром, Сибур, ЛенСтройТрест, Альфа Капитал и т.д. P.S. Этот сайт - его работа от дизайна до деплоя.'
    pic: 'trainer_pic.jpg'
  }

if Cities.find({}).count() < 3
  Cities.insert {alias: 'msk', name: 'Москва', phone: '+7 (495) 545-50-50'}
  Cities.insert {alias: 'spb', name: 'Санк-Петербург', phone: '+7 (812) 545-50-50'}
  Cities.insert {alias: 'kiev', name: 'Киев', phone: '+33 (495) 545-50-50'}

if Events.find({}).count() < 15
  date = new Date()
  date.setFullYear(2014, 2, 28)
  date.setDate(_.random(1, 31))
  Events.insert {
    id: Events.find({}).count() + 1
    course: 'html5'
    city: 'msk'
    date: date
    trainer: 1
    pop: true
  }


if Meteor.users.find().count() is 0
  user = Accounts.createUser {
    username: 'albertkai'
    email: 'albertkai@me.com'
    password: '56114144as'
    profile: {
      name: 'Альберт',
      surname: 'Кайгородов'
    }
  }
  Roles.addUsersToRoles(user, ['root','admin'])

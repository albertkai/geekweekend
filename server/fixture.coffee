if Courses.find({}).count() < 11
  Courses.insert {
    alias: 'html5'
    sphere: 'webdev'
    pop: true
    title: 'html5 + css3'
    type: _.random(1, 3)
    shortDesc: 'Основы веб-разработки'
    desc: 'Данный курс - лучшее, что может предложить индустрия на данный момент! Вы пройдете как и базовые, так и другие темы'
    pic: 'htmll.png'
    price: 3000
    events: [
      ['msk', '22.01.12'],
      ['spb', '24.06.14']
    ]
    trainer: 1
    skills: ['Узнаете о разработке', 'Научитксь писать сайты',  'Изучите современный инструментарий разработчика']
    topics: ['HTML5: основы, теги и аттрибуты, лучшие практики', 'CSS3: основы, box-model, поток, лучшие практики', 'HTML5 Boilerplate и Twitter Bootstrap', 'ZenCoding', 'Chrome Devtools', 'Webstorm IDE']
    require: ['Знание компьютера',  'Желание', 'Черный пояс']
  }

if Trainers.find({}).count() < 5
  Trainers.insert {
    id: 1
    name: 'Альберт'
    secondName: 'Кайгородов'
    skills: ['HTML5', 'CSS3', 'JS/JQUERY', 'UI/UX', 'NODE.JS', 'BACKBONE.JS', 'METEOR.JS']
    about: 'Занимется веб-разработкой с 2007 года, является frontend-разработчиком высшего класса. Сотрудничал с такими компаниями как Газпром, Сибур, ЛенСтройТрест, Альфа Капитал и т.д. P.S. Этот сайт - его работа от дизайна до деплоя.'
  }

if Cities.find({}).count() < 3
  Cities.insert {alias: 'msk', name: 'Москва', phone: '+7 (495) 545-50-50'}
  Cities.insert {alias: 'spb', name: 'Санк-Петербург', phone: '+7 (812) 545-50-50'}
  Cities.insert {alias: 'kiev', name: 'Киев', phone: '+33 (495) 545-50-50'}
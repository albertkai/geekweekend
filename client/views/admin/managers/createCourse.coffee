Template.createCourse.events {
  'dragover .drop-pic': (e)->
#    $('.drop-pic').addClass '_hover'
    createCourseCtrl.cancel(e)
  'drop .drop-pic': (e)->
    createCourseCtrl.cancel(e)
    createCourseCtrl.dropHandler(e)

  'change #chooseTrainer': (e)->
    id = $(e.target).val()
    if id isnt 'none'
      trainer = Trainers.findOne {_id: id}
      html = Meteor.render ->Template.createCourseTrainer {trainer: trainer}
      $('#coach').html(html)
    else
      $('#coach').empty()

  'click .add': (e)->
    markup = '<div><p contenteditable="true">00:00</p><p contenteditable="true">Встречаемся, базарим по душам</p></div>'
    $(e.target).closest('.add').before(markup)

  'click #save-course': ->
    createCourseCtrl.saveCourse()
}

Template.createCourse.helpers {
  trainersList: ->
    Trainers.find({})
}




createCourseCtrl = {

  data: {}

  pic: {}

  dropHandler: (e)->

    reader = new FileReader()
    console.log e.dataTransfer.files[0]
    file = e.dataTransfer.files[0]
    reader.readAsDataURL(file)
    reader.onload = (e)->
      image = new Image()
      image.src = e.target.result
      $('#course-pic').css('background-image', 'url(' + e.target.result + ')')


    resize = ()->
      deferred = $.Deferred()
      $.canvasResize(file, {
        width: 300,
        height: 0,
        crop: false,
        quality: 80,
        callback: (data, width, height)->
          deferred.resolve(data)
          console.log {data: data}
      })
      deferred.promise()


    originalFile = ()->
      reader = new FileReader()
      deferred = $.Deferred()
      reader.readAsBinaryString(file)
      reader.onload = (e)->
        ifile = reader.result
        deferred.resolve(ifile)
        console.log {reader: ifile}
      deferred.promise()

    $.when(originalFile(), resize()).done (ifile, resizedFile)=>
      @pic['fileInfo'] = file
      @pic['originalPic'] = ifile
      @pic['resizedPic'] = resizedFile
#      Meteor.call 'upload', file, ifile, resizedFile


  cancel: (e)->
    if e.preventDefault then e.preventDefault()
    return false

  saveCourse: ->
    @data['alias'] = $('#alias').val()
    @data['sphere'] = $('#sphere').val()
    @data['title'] = $('[data-field="title"]').html()
    @data['shortDesc'] = $('[data-field="shortDesc"]').html()
    @data['desc'] = $('[data-field="desc"]').html()
    @data['saturday'] = $('[data-field="schedule.saturday"]').html()
    @data['sunday'] = $('[data-field="schedule.sunday"]').html()
    @data['trainer'] = $('[data-field="trainer"]').val()
    @data['skills'] = $('[data-field="skills"]').html()
    @data['topics'] = $('[data-field="topics"]').html()
    @data['require'] = $('[data-field="require"]').html()
    Meteor.call 'createCourse', @data, (err, result)->
      if err
        $.jGrowl('Ошибка на стадии сохранения текста, смотри консоль')
        console.log err
      else
        console.log 'Course saved, id: ' + result
        Meteor.call 'uploadCoursePic', result, createCourseCtrl.pic, (error, res)->
          if error
            $.jGrowl('Ошибка на стадии сохранения фотки, смотри консоль')
            console.log error
          else
            $.jGrowl('Курс сохранен!')
            console.log 'yoyoyo'

}
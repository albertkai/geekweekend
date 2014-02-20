

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

  updateOrder: (id, status)->
    if methodsCtrl.checkRole ['admin', 'root']
      Orders.update id, {$set: {status: status}}
      true
    else
      false

  deleteOrder: (id)->
    if methodsCtrl.checkRole ['admin', 'root']
      Orders.remove id
      true
    else
      false


  createRequest: (request)->

    future = new Future()
    Regulate.sendRequest.validate request, (error, data)->
      if error
        console.log error
        future.return false
      else
        newRequest = {}
        for obj in data
          newRequest[obj.name] = obj.value
        Requests.insert newRequest
        future.return true

    return future.wait()

  updateRequest: (id, status)->
    if methodsCtrl.checkRole ['admin', 'root']
      Requests.update id, {$set: {status: status}}
      true
    else
      false

  deleteRequest: (id, status)->
    if methodsCtrl.checkRole ['admin', 'root']
      Requests.remove id
      true
    else
      false

  createCourse: (data)->
    course = Courses.insert {
      alias: data.alias
      sphere: data.sphere
      title: data.title
      shortDesc: data.shortDesc
      desc: data.desc
      schedule: {
        saturday: data.saturday
        sunday: data.sunday
      }
      trainer: data.trainer
      skills: data.skills
      topics: data.topics
      require: data.require
    }
    course


  uploadCoursePic: (id, pic)->

    dataUriToBuffer = Meteor.require('data-uri-to-buffer')
    s3 = new AWS.S3()

    buffer = new Buffer(pic.originalPic, 'binary')
    resizedBuffer = dataUriToBuffer(pic.resizedPic)
    images = []

    origImage =  {
      Key: 'orig_' + pic.fileInfo.name
      ContentType: pic.fileInfo.type
      Body: buffer
      Bucket: 'thisIsAlbertsTestBucket'
    }

    resizedImage = {
      Key: 'resized_' + pic.fileInfo.name
      ContentType: pic.fileInfo.type
      Body: resizedBuffer
      Bucket: 'thisIsAlbertsTestBucket'
    }

    f = new Future()

    s3.putObject origImage, (err, data)->
      if err
        console.log err
        f.return()
      else
        console.log 'uploaded to S3'
        f.return

    f.wait()

    f = new Future()

    s3.putObject resizedImage, (err, data)->
      if err
        console.log err
        f.return()
      else
        console.log 'uploaded to S3'
        f.return()

    f.wait()

    console.log id
    Courses.update id, {$set: {pic: pic.fileInfo.name}}





  emailSend: (options)->
#    console.log 'email sent'
#    Email.send options
    s3 = new AWS.S3()
    data =
      Key: 'Coolstuff'
      Body: 'Hello!!'
      Bucket: 'thisIsAlbertsTestBucket'






subscribe: (email)->
    future = new Future()
    Regulate.subscribe.validate email, (error, data)->
      if error
        console.log error
        future.return false
      else
        newSubscription = {}
        for obj in data
          newSubscription[obj.name] = obj.value
        if Subscribers.find({email: newSubscription.email}).count() is 0
          Subscribers.insert newSubscription
          future.return true
        else
          future.return false

    return future.wait()

}


methodsCtrl = {


  checkRole: (roles)->

    if !Meteor.user()
      return false
    user = Meteor.user()
    if !Roles.userIsInRole user, roles
      return false
    else
      return true
}
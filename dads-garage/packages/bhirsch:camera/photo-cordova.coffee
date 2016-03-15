MeteorCamera.getPicture = (options, callback) ->
  # if options are not passed
  if !callback
    callback = options
    options = {}

  success = (data) ->
    callback null, 'data:image/jpeg;base64,' + data
    return

  failure = (error) ->
    callback new (Meteor.Error)('cordovaError', error)
    return

  navigator.camera.getPicture success, failure, _.extend(options,
    quality: options.quality or 49
    targetWidth: options.width or 640
    targetHeight: options.height or 480
    destinationType: Camera.DestinationType.DATA_URL)
  return

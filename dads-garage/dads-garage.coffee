if Meteor.isServer
  ActivePage.remove {}
  ActivePage.set 'home'

  # Configure AWS
  AWS.config.update
    accessKeyId: 'AKIAJM745M2HH3ZT27IQ'
    secretAccessKey: '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'

  # Make sure all songs in s3 are in the database
  s3 = new AWS.S3()

  list = s3.listObjectsSync
    Bucket: 'dads-garage-music'

  for song in list.Contents
    if song.Key[song.Key.length-4..] == '.mp3'
      Song.add song.Key

if Meteor.isClient
  uid = Cookie.get 'dads-garage-uid'
  if not uid
    uid = User.insert {}
    Cookie.set 'dads-garage-uid', uid

  @userId = uid

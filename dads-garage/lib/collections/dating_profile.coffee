@DatingProfile = new Mongo.Collection 'dating_profile'

@DatingProfile.add = (lName, fName, age, ) ->
  DatingProfile.insert lName: lname, fName: fName, age: age

@DatingProfile.getYoungest = ->
  DatingProfile.

config = require('../../config/config.coffee')

mongoose = require('mongoose')

beforeEach (done) ->
  ###
  clearDB = ->
    for i of mongoose.connection.collections
      mongoose.connection.collections[i].remove ->
  ###

  if mongoose.connection.readyState == 0
    mongoose.connect config.mongodsn, (err) ->
      if err
        throw err
      done()
  else
    done()


afterEach (done) ->
  mongoose.disconnect()
  done()


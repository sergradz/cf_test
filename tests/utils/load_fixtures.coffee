###*
#
# Seed data for tests
###

Promise = require('promise')
mongoose = require('mongoose')
config = require('../../config/config.coffee')
ObjectId = require('mongoose').Types.ObjectId
logger = require("tracer").console()

loaded = false
beforeEach (done) ->
  if loaded
    return done()

  db = mongoose.connection

  messages = require("../fixtures/messages")
  messagesCollection = db.collection('messages')
  messagesCollection.drop()
  messagesPromises = new Promise((resolve, reject) ->
    messagesCollection.insert messages, (err, apps) ->
      if err
        reject err
      else
        resolve messages
  )

  # other fixtures if needed

  Promise.all([messagesPromises]).done ((results) ->
    logger.log 'Seed data has been successfully loaded'
    loaded = true
    done()
  ), (err) ->
    logger.error err

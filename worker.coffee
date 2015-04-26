###
  Worker for our queue
###

config = require './config/config.coffee'
ironMq = require 'iron_mq'
mongoose = require 'mongoose'
logger = require("tracer").console()
Message = require './lib/models/message.coffee'

io = require('socket.io-emitter')(config.redis);

mongoose.connect config.mongodsn
db = mongoose.connection
db.on "error", ->
  logger.error("connection error:")
db.once "open", ->
  logger.info "Mongo connected"

ironMqClient = new ironMq.Client(config.ironmq)
queue = ironMqClient.queue(config.ironmq.queue_name)

checkTimeout = config.queue_timeout || 1000


checkQueue = () ->
  logger.info("Checking the queue")
  queue.get {}, (error, body) ->
    return logger.error(error) if error
    unless body
      setTimeout checkQueue, checkTimeout # check queue next time after specified timeout
      return logger.info("Queue is empty")
    # won't be too fancy here for now just save message to mongo

    messageData = JSON.parse(body.body)
    logger.info messageData
    message = new Message(messageData)
    message.save (error, message) ->
      if error
        # for now just delete message from queue. Perhaps add fallback here, but not in this scope
        logger.error(error)
      logger.info message

      Message.count (error, count) ->
        data =
          total: count
          time: new Date()
        console.log data
        io.emit('new_data', data);

      checkQueue()
      queue.del body.id, (error, body) ->
        return logger.error(error) if error

checkQueue()
express = require("express")
router = express.Router()
logger = require("tracer").console()
ironMq = require 'iron_mq'
config = require "../../config/config.coffee"

ironMqClient = new ironMq.Client(config.ironmq);
queue = ironMqClient.queue(config.ironmq.queue_name);


sendError = (res, err, code = 400) ->
  logger.error err
  res.status(code)
  res.send err

###*
  Post message
  POST /api/messages
###
router.post "/", (req, res) ->
  message = JSON.stringify(req.body)
  console.log message
  # perhaps some validation but not in this scope
  queue.post message, (error, body) ->
    if error
      return sendError(res, error)
    res.status(201)
    res.json
      result: "OK"

module.exports = router
config = require '../config/config.coffee'
fakeMessage = require '../lib/services/fake_message.coffee'
moment = require 'moment'
rest = require 'restler'
logger = require("tracer").console()
_ = require 'underscore'

generateEvent = () ->
  message = fakeMessage
    currencyFrom: "USD"
    currencyTo: "GBP"
    timePlaced: moment().format('DD-MMM-YYYY hh:mm:ss')

  jsonMessage = JSON.stringify(message)
  logger.info "Posting message: " + jsonMessage
  rest.post(config.baseUrl + '/api/messages', data: message).on 'complete', (data, response) ->
    if response.statusCode != 201
      console.error "Cannot post message"
  intervalTimeout = _.random(100, 3000)
  setTimeout(generateEvent, intervalTimeout)


generateEvent();

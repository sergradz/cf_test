config = require '../config/config.coffee'
fakeMessage = require '../lib/services/fake_message.coffee'
moment = require 'moment'
rest = require 'restler'
logger = require("tracer").console()
_ = require 'underscore'

sampleCurrencyCodes = ["USD", "GBP", "EUR", "CHF"]


generateEvent = () ->

  currencyFromId = _.random(0, sampleCurrencyCodes.length - 2)
  currencyToId = _.random(currencyFromId + 1, sampleCurrencyCodes.length - 1)

  message = fakeMessage
    currencyFrom: sampleCurrencyCodes[currencyFromId]
    currencyTo: sampleCurrencyCodes[currencyToId]
    timePlaced: moment().format('DD-MMM-YYYY hh:mm:ss')

  console.log message

  jsonMessage = JSON.stringify(message)
  logger.info "Posting message: " + jsonMessage
  rest.post(config.baseUrl + '/api/messages', data: message, {'Authorization': 'bearer demo'}).on 'complete', (data, response) ->
    if response && typeof response.statusCode != 'undefined' && response.statusCode != 201
      console.error "Cannot post message"
  intervalTimeout = _.random(100, 1000)
  setTimeout(generateEvent, intervalTimeout)


generateEvent();

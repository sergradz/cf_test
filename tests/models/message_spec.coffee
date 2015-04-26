utils = require '../utils/mongoose_loading'
loadFixtures = require('../utils/load_fixtures');
_ = require 'underscore'
moment = require 'moment'
Message = require '../../lib/models/message'
fakeMessage = require '../../lib/services/fake_message.coffee'


describe "Message", () ->

  it "can create message", (done) ->
    messageData = fakeMessage()
    message = new Message(messageData)
    message.save (error, message) ->
      expect(error).toBeNull()
      expect(message._id).not.toBeNull()
      expect(message.userId).toBe(messageData.userId)
      expect(message.currencyFrom).toBe(messageData.currencyFrom)
      expect(message.currencyTo).toBe(messageData.currencyTo)
      expect(message.amountSell).toBe(messageData.amountSell)
      expect(message.amountBuy).toBe(messageData.amountBuy)
      expect(message.rate).toBe(messageData.rate)
      timePlaced = moment(messageData.timePlaced, 'DD-MMM-YYYY hh:mm:ss').toDate()
      expect(message.timePlaced.valueOf()).toBe(timePlaced.valueOf())
      expect(message.originatingCountry).toBe(messageData.originatingCountry)
      done()

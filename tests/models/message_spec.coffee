utils = require '../utils/mongoose_loading'
loadFixtures = require('../utils/load_fixtures');
_ = require 'underscore'
Message = require '../../lib/models/message'
fakeMessage = require '../../lib/services/fake_message.coffee'


describe "Message", () ->


  it "can create message", (done) ->
    messageData = fakeMessage()

    message = new Message(messageData)
    message.save (error, message) ->
      expect(error).toBeNull()
      console.log message
      done()

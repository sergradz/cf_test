frisby = require 'frisby'
config = require '../../config/config.coffee'
fakeMessage = require '../../lib/services/fake_message.coffee'

message = fakeMessage()
frisby.create('Test post message')
.post config.baseUrl + '/api/messages', message
#.inspectJSON()
.expectJSON
    result: "OK"
.toss()
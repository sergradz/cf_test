frisby = require 'frisby'
config = require '../../config/config.coffee'

console.log config

message =
  'userId': '134256'
  'currencyFrom': 'EUR'
  'currencyTo': 'GBP'
  'amountSell': 1000
  'amountBuy': 747.10
  'rate': 0.7471
  'timePlaced': '24-JAN-15 10:27:44'
  'originatingCountry': 'FR'

frisby.create('Test post message')
.post config.baseUrl + '/api/messages', message
#.inspectJSON()
.expectJSON
    result: "OK"
.toss()
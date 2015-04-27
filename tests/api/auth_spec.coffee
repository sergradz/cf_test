frisby = require('frisby')
config = require '../../config/config.coffee'

frisby.create('Test API authorization')
.post config.baseUrl + '/api/messages'
#.inspectBody()
.expectBodyContains("Access denied")
.expectStatus(403)
.toss()
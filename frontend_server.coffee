###

###
express = require 'express'
app = express()
http = require("http").Server(app)
io = require('socket.io')(http);
socketIoRedis = require 'socket.io-redis'
logger = require("tracer").console()
path = require 'path'

config = require("./config/config.coffee")
io.adapter(socketIoRedis(config.redis))


io.on 'connection', (socket) ->
  logger.info('a user connected')

# serve static files
app.use express.static(path.join(__dirname, "/public"))

env = process.env.NODE_ENV || "development"
logger.info "Starting frontend server " + env + " environment"
http.listen config.frontend_port, ->
  logger.info "listening on *:" + config.frontend_port

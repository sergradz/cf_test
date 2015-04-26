###

###
express = require("express")
app = express()
http = require("http").Server(app)
io = require('socket.io')(http);
socketIoRedis = require 'socket.io-redis'
logger = require("tracer").console()

config = require("./config/config.coffee")
io.adapter(socketIoRedis(config.redis))


io.on 'connection', (socket) ->
  logger.info('a user connected')

app.get '/', (req, res) ->
  res.sendfile('public/index.html')


env = process.env.NODE_ENV || "development"
logger.info "Starting frontend server " + env + " environment"
http.listen config.frontend_port, ->
  logger.info "listening on *:" + config.frontend_port

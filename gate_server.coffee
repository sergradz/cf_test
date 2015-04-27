###

###
express = require("express")
app = express()
http = require("http").Server(app)
logger = require("tracer").console()
bodyParser = require("body-parser")

config = require("./config/config.coffee")

app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)

app.use require("./lib/services/api_auth")

# routes
app.use "/api/messages", require "./routes/api/messages"


env = process.env.NODE_ENV || "development"
logger.info "Starting consumer server " + env + " environment"
http.listen config.api_port, ->
  logger.info "listening on *:" + config.api_port

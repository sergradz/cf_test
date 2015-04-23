express = require("express")
router = express.Router()
logger = require("tracer").console()

###*
  Create user
  POST /api/messages
###
router.post "/", (req, res) ->
  userData = req.body
  res.status(201)
  res.json
    result: "OK"



module.exports = router
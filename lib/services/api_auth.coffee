###
  Authorize API calls
  use bearer demo token for demo
###
module.exports = (req, res, next) ->
  originalUrl = req.originalUrl.toString()
  re = new RegExp("/api")
  if re.test originalUrl
    authHeader = req.header("Authorization")

    if authHeader
      tokenType = authHeader.substr(0, authHeader.indexOf(" ")).trim().toLowerCase()
      if tokenType == "bearer"
        token = authHeader.substr(authHeader.indexOf(" ")).trim()
        if token == "demo"
          next()
        else
          res.status(403).send("Access denied").end()
      else
        res.status(403).send("Access denied").end()
    else
      res.status(403).send("Access denied").end()
  else
    next()

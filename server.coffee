require("coffee-script/register")
logErrors = (err, req, res, next) ->
  console.error err.stack
  next err
  return
clientErrorHandler = (err, req, res, next) ->
  if req.xhr
    res.send 500,
      error: "Something blew up!"

  else
    next err
  return
errorHandler = (err, req, res, next) ->
  res.status 500
  res.render "error",
    error: err

  return
express = require("express")
app = express()
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use logErrors
  app.use clientErrorHandler
  app.use errorHandler
  app.use "/static", express.static(__dirname + "/static")
  return 

mongo = require("mongoskin")
uristring = "mongodb://localhost:27017/boerp"
app.set "db-uri", uristring
mongodb = mongo.db(uristring,
  native_parser: true
)
mongoose = require("mongoose")
mongoose.connect uristring, (err, res) ->
  if err
    console.log "error connect to " + uristring + ". " + err
  else
    console.log "success connect to " + uristring
  return

redis = require("redis")
db = redis.createClient("6379", "127.0.0.1")
app.use (req, res, next) ->
  ua = req.headers["user-agent"]
  db.zadd "online", Date.now(), ua, next
  return

app.use (req, res, next) ->
  min = 60 * 1000
  ago = Date.now() - min
  db.zrevrangebyscore "online", "+inf", ago, (err, users) ->
    if err
      req.online = []
      return next(err)
    req.online = users
    next()
    return

  return

routes = require("./routes/index")
routes.initialize(app,mongodb)
server = app.listen(3000, ->
  console.log "Listening on port %d", server.address().port
  return
)

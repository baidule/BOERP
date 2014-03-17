require("coffee-script/register")
app= require("./app")
server = app.listen(8001, ->
  console.log "Listening on port %d", server.address().port
  return
)
module.exports = server

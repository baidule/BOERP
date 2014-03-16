exports.index = (req, res) ->
  res.render "index",
    title: "首页-BOERP"
    address: "中国"

  return
exports.initialize = (app,mongodb)->
	app.get "/", (req, res) ->
	  res.render "index",
	    title: "首页-BOERP"
	    address: "中国"

	  return
	user = require("./user")
	app.get "/user", user.list(mongodb)
	app.post "/user", user.create(mongodb)
	app.delete "/user/:id",user.remove(mongodb)
	return

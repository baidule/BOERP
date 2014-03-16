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
	user = require("./users")
	app.get "/users", user.list(mongodb)
	app.post "/users", user.create(mongodb)
	app.put "/users/:id",user.update(mongodb)
	app.delete "/users/:id",user.remove(mongodb)
	return

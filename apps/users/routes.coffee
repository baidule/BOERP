mongoose = rquire('mongoose')
User = mongoose.model('User')

routes = (app)->
	app.get '/users',(req,res)->
		User.find (err,users)->
			res.send users
	app.get '/users/:id',(req,res)->
		User.findOne {'_id':req.param.id},(err,user)->
			res.send user
	#create a user
	app.post '/users',(req,res)->
		attributes=
			username:req.body.username
		user = new User attributes
		user.save ()->
			res.send req.body
	app.put '/users/:id',(req,res)->
		User.findByIdAndUpdate req.param.id,req.body,(err,user)->
			res.send user

module.exports = routes	

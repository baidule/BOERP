request = require("supertest")
require("should")
app = require("../server.coffee")
describe "app", ->
  # before (done) ->
  #   app.listen 0, (done)->
	
  #   return
	it "GET / should show the title", (done) ->
	  request(app).get("/").expect(200).end (err, res) ->
	    body = res.text
	    # 主页面显示介绍和表单
	    body.should.containEql "<title>首页-BOERP</title>"
	    # body.should.include "<form"
	    # body.should.include "</form>"
	    # body.should.include "<input"
	    done err
	    return

	it "GET /other should not found the page", (done) ->
	  request(app).get("/noexists").expect(404,done)
	  return
  describe "user restful api",->
  	it "GET /users show return user list json result",(done)->
  		request(app).get("/users").expect(200).end (err,res)->
  			res.should.be.json
  			done err
  			return
  	it "POST /users with duplicate username should return error",(done)->
  		user =
  			username:"test"
  			email:"test@test.com"
  			password:"test"
  		request(app).post("/users").send(user).end (err,res)->
  			res.should.have.status 400
  			done err
  			return
  	it "PUT /users should update user correctly",(done)->
  		body =
  			username:"test"
  			email:"test2@test.com"
  			password:"test"
  		request(app).put('/users').send(body).expect(200).end (err,res)->
  			res.should.have.propery "_id"
  			res.username.should.equal "test"
  			res.email.should.equal "test2@test.com"
  			done err
  		return
  	it "PUT /users with incorrectly password should not update user",(done)->
  		return
	describe "voncher restful api",->
		it "GET /vonchers should return voncher list json result",(done)->
			request(app).get('/vonchers').expect(200).end (err,res)->
				res.should.be.json
				done err
				return
		it "POST /vonchers"
  return


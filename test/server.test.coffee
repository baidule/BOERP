request = require("supertest")
app = require("../server.coffee")
describe "app", ->
  # before (done) ->
  #   app.listen 0, (done)->
	
  #   return
	it "GET / should show the title", (done) ->
	  request(app).get("/").expect(200).end (err, res) ->
	    body = res.text
	    # 主页面显示介绍和表单
	    # body.should.include "<title>首页</title>"
	    # body.should.include "<form"
	    # body.should.include "</form>"
	    # body.should.include "<input"
	    done err
	    return
		# return
	it "GET /api should have an api", (done) ->
	  request(app).get("/api").expect(200,done)
	  return

	it "GET /other should not found the page", (done) ->
	  request(app).get("/noexists").expect(404,done)
	  return
  return


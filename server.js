var express = require('express');
var app = express();
app.configure(
  function() {
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(logErrors);
    app.use(clientErrorHandler);
    app.use(errorHandler);
    app.use('/static',express.static(__dirname + '/static'));
  });
var mongo = require('mongoskin');
var mongodb = mongo.db("mongodb://localhost:27017/boerp", {native_parser:true});
// app.configure('development', function() {

//   app.use(express.errorHandler({
//     dumpExceptions: true, 
//     showStack: true  
//   })); 
 
//   log("Warning: Server in Development Mode, add NODE_ENV=production", true);
 
// });



// app.configure('production', function() {

//   app.use(express.errorHandler());

//   log("Production Mode");

// });

var redis = require('redis');
// var db = redis.createClient('6379', '192.168.184.130');
var db = redis.createClient('6379', '127.0.0.1');

app.use(function(req, res, next) {
  var ua = req.headers['user-agent'];
  db.zadd('online', Date.now(), ua, next);
});
app.use(function(req, res, next) {
  var min = 60 * 1000;
  var ago = Date.now() - min;
  db.zrevrangebyscore('online', '+inf', ago, function(err, users) {
    if (err) {
      req.online = [];
      return next(err);
    }
    req.online = users;
    next();
  });
});

function logErrors(err, req, res, next) {
  console.error(err.stack);
  next(err);
}

function clientErrorHandler(err, req, res, next) {
  if (req.xhr) {
    res.send(500, {
      error: 'Something blew up!'
    });
  } else {
    next(err);
  }
}

function errorHandler(err, req, res, next) {
  res.status(500);
  res.render('error', {
    error: err
  });
}
var fs = require('fs');
var info = JSON.parse(fs.readFileSync('chinese.json', 'utf8'));
var routes = JSON.parse(fs.readFileSync('router.json', 'utf8'));



// Start router

var routes = require('./routes');
app.get('/', routes.index);
var user=require('./routes/user');
app.get('/user',user.list(mongodb));
app.post('/user',user.create(mongodb));
app.delete('/user/:id',user.delete(mongodb));

// var startRouter = function(path) {
//   app.get(route, function(req, res) {
//     //console.log("Connect to "+path);

//     var page = info[routes[path].data];

//     res.render(routes[path].template, page); //最核心的一句
 
//   }); 

// };



// for (route in routes) { //如果直接for循环而不是调用函数，你就会发现route永远是最后一个

//   startRouter(route);

// }



//File not found



// app.get('/*', function(req, res) {
//   res.render('404', {
//     status: 404,
//     title: '404 - 文件未找到'
//   });
// });
// app.get('/', function(req, res) {
//   var min = 60 * 1000;
//   var ago = Date.now() - min;
//   db.zrevrangebyscore('online', '+inf', ago, function(err, users) {
//     if (err) {
//       req.online = [];
//     }
//     req.online = users;
//     res.send(req.online.length + ' users online');
//   });

// });
var server = app.listen(3000, function() {
  console.log('Listening on port %d', server.address().port);
});
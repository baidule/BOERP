exports.index = function(req, res) {
	res.render('index', {
		'title': '首页-BOERP',
		'address': '中国'
	})
}
exports.userlist = function(db) {
	return function(req, res) {
		var collection = db.get('usercollection');
		collection.find({}, {}, function(e, docs) {
			res.json(docs);
		})
	}
}
exports.newuser = function(db) {
	return function(req, res) {
		// Get our form values. These rely on the "name" attributes
        var userName = req.body.username;
        var userEmail = req.body.useremail;

        // Set our collection
        var collection = db.get('usercollection');

        // Submit to the DB
        collection.insert({
            "username" : userName,
            "email" : userEmail
        }, function (err, doc) {
            if (err) {
            	console.log(err);
                // If it failed, return error
                res.json({'success':0,'message':err});
            }
            else {
                res.json({'success':0});
            }
        });
	}
}
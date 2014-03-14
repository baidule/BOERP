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
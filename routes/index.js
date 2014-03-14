exports.index = function(req, res) {
	res.render('index', {
		'title': '首页-BOERP',
		'address': '中国'
	})
}

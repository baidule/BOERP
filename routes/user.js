exports.list = function(db) {
    return function(req, res) {
        db.collection('usercollection').find().toArray(function(e, docs) {
            res.json(docs);
        })
    }
}
exports.create = function(db) {
    return function(req, res) {
        // Get our form values. These rely on the "name" attributes
        var userName = req.body.username;
        var userEmail = req.body.useremail;

        // Set our collection
        var collection = db.collection('usercollection');

        // Submit to the DB
        collection.insert({
            "username": userName,
            "email": userEmail
        }, function(err, doc) {
            if (err) {
                console.log(err);
                // If it failed, return error
                res.json({
                    'success': 0,
                    'message': err
                });
            } else {
                res.json({
                    'success': 1
                });
            }
        });
    }
}
exports.delete = function(db) {
    return function(req, res) {
        var userToDelete = req.params.id;
        db.collection('usercollection').removeById(userToDelete, function(err, result) {
            res.json((result === 1) ? {
                msg: ''
            } : {
                msg: 'error: ' + err
            });
        });
    }
};
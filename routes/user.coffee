exports.list = (db) ->
  (req, res) ->
    db.collection("usercollection").find().toArray (e, docs) ->
      res.json docs
      return
    return

exports.create = (db) ->
  (req, res) ->
    # Get our form values. These rely on the "name" attributes
    userName = req.body.username
    userEmail = req.body.useremail
    
    # Set our collection
    collection = db.collection("usercollection")
    
    # Submit to the DB
    collection.insert
      username: userName
      email: userEmail
    , (err, doc) ->
      if err
        console.log err
        # If it failed, return error
        res.json
          success: 0
          message: err
      else
        res.json success: 1
      return
    return
exports.remove = (db)->
  (req, res) ->
    userToDelete = req.params.id
    # Set our collection
    collection = db.collection("usercollection")
    collection.removeById userToDelete, (err, result) ->
      if result is 1 
        res.json
          success:1
          msg: ""
      else
        res.json
          success:0
          msg:"error"+err

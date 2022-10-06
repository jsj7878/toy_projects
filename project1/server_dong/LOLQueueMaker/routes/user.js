var express = require('express');
var router = express.Router();
var mysql = require('../database/connect/mysql')

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.status(500).end();
});

router.post('/', function(req, res, next) {
  var post = req.body;
  var user_name = post.user_name;
  var tier = post.tier;
  var position = post.position;
  var description = post.description;

  console.log(req);
  // console.log(user_name, tier, position, description);

  mysql.query(`SELECT * FROM User WHERE name=?`, [user_name], function(error, rows, fields){
    if(error){
      throw error;
    }
    console.log('db select', rows, fields);
    if(Object.keys(rows).length == 0) {
      mysql.query(`INSERT INTO User (name, tier, position, description, created_at, updated_at) VALUES(?, ?, ?, ?, NOW(), NOW())`, [user_name, tier, position, description], function(error, rows, fields){
        if(error){
          throw error;
        }
        console.log('db insert', rows);
        res.status(200).end();
      });
    }
    else {
      mysql.query(`UPDATE User SET tier=?, position=?, description=? updated_at=NOW() where name=?`,
      [tier, position, description, user_name], function(error, rows, fields){
        if(error){
          throw error;
        }
        console.log('db update', rows);
        res.status(200).end();
      });
    }
  });
});

module.exports = router;

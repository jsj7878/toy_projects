var express = require('express');
var router = express.Router();
var mysql = require('../database/connect/mysql');

/* GET home page. */
router.get('/', function(req, res, next) {
    res.status(200).end();
});

router.post('/', function(req, res, next) {
  var post = req.body;
  var room_name = post.room_name;
  var master_id = post.master_id;
  var tier_min = post.tier_min;
  var tier_max = post.tier_max;
  var description = post.description;
  var people_max = post.people_max;

  mysql.query(`INSERT INTO Room (name, master_id, tier_min, tier_max, description, people_now, people_max, created_at, updated_at) VALUES(?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
  [room_name, master_id, tier_min, tier_max, description, 1, people_max], function(error, rows, fields){
    if (error){
        throw error;
    }
    console.log(rows);
    res.status(200).end();
  });

});

module.exports = router;

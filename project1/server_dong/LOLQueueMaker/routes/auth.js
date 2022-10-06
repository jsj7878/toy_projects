var express = require('express');
var router = express.Router();
var mysql = require('../database/connect/mysql');
 
// mysql.connect();

/* GET users listing. */
router.get('/login', function(req, res, next) {
  res.render('auth');
});

router.post('/login_process', function(req, res, next) {
  var post = req.body;
  var nickname = post.nickname;
  var sol_rank = post.sol_rank_league + post.sol_rank_num;
  var free_rank = post.free_rank_league + post.free_rank_num;
  var ladder_rank = post.ladder_rank;
  var position = post.position;
  var description = post.description;


  if (nickname !== ''){
    console.log('post_body', post);
    req.session.is_logined = true;
    req.session.user_name = nickname;

    mysql.query(`SELECT * FROM User WHERE name=?`, [nickname], function(error, result){
      if(error){
        throw error;
      }
      console.log('db select', result);
      if(Object.keys(result).length == 0) {
        mysql.query(`INSERT INTO User (name, sol_rank, free_rank, ladder_rank, position, description) VALUES(?, ?, ?, ?, ?, ?)`, [nickname, sol_rank, free_rank, ladder_rank, position, description], function(error, result){
          if(error){
            throw error;
          }
          console.log('db insert', result);
        });
      }
      else {
        mysql.query(`UPDATE User SET sol_rank=?, free_rank=?, ladder_rank=?, position=?, description=? where name=?`,
        [sol_rank, free_rank, ladder_rank, position, description, nickname], function(error, result){
          if(error){
            throw error;
          }
          console.log('db update', result);
        });
      }
    });
    res.redirect('/');
  } else {
    res.redirect('/auth/login');
  }

});

router.get('/logout', function(req, res, next){
  req.session.destroy(function(err){
      res.redirect('/');
  });
});

module.exports = router;

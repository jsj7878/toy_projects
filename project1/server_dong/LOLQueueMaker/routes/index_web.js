var express = require('express');
var router = express.Router();
var mysql = require('../database/connect/mysql');

/* GET home page. */
router.get('/', function(req, res, next) {
  // WEB PART
  console.log(req.session);
  var user_name = '';
  if(req.session.is_logined){
    user_name = req.session.user_name;
  }
  res.render('index', { title: 'LOL 5QUEUE', islogin: req.session.is_logined, user_name: user_name });
});

router.post('/', function(req, res, next) {
  

});

module.exports = router;

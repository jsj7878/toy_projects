var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  console.log(req.session);
  var user_name = '';
  if(req.session.is_logined){
    user_name = req.session.user_name;
  }
  res.render('index', { title: 'LOL 5QUEUE', islogin: req.session.is_logined, user_name: user_name });
});

module.exports = router;

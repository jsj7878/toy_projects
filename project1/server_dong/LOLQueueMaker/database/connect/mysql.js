var mysql = require('mysql');

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'lolprojectmanager',
  password: 'mysql903!',
  database: 'LOLQueueMaker'
});

module.exports = connection;
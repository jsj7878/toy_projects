var express = require('express');
var router = express.Router();
var mysql = require('../database/connect/mysql');

function getTierScore(tier){
    var tiers = ['iron', 'bronze', 'silver', 'gold', 'platinum', 'diamond', 'master', 'grandmaster', ' challenger'];
    t = tier.split(' ');
    league = tiers.indexOf(t[0])*10;
    rank_num = Number(t[1]);
    return league + rank_num;
}

/* GET home page. */
router.get('/', function(req, res, next) {
    mysql.query(`SELECT * FROM User INNER JOIN Room on User.room_id = Room.id`, function(error, rows, fields) {
        if (error){
            throw error;
        }
        console.log(rows, fields);
        res.send(rows);
    });
});

router.post('/', function(req, res, next) {
    var tiers = ['iron', 'bronze', 'silver', 'gold', 'platinum', 'diamond', 'master', 'grandmaster', ' challenger'];
    var post = req.body;
    var room_name = post.room_name;
    var user_name = post.user_name;

    mysql.query(`SELECT * FROM Room WHERE name=? `, [room_name], function(room_error, room_rows, room_fields){
        if(room_error) {
            throw room_error;
        }
        console.log('db select room', room_rows);
        mysql.query(`SELECT * FROM User WHERE name=?`, [user_name], function(user_error, user_rows, user_fields){
            if(user_error) {
                throw user_error;
            }
            console.log('db select user', user_rows);

            // var mint = room_rows[0].tier_min.split(' ');
            // var maxt = room_rows[0].tier_max.split(' ');
            // var usert = user_rows[0].tier.split(' ');
            // var room_min_tier = tiers.indexOf(mint[0] * 10) + Number(mint[1]);
            // var room_max_tier = tiers.indexOf(maxt[0] * 10) + Number(maxt[1]);
            // var user_tier = tiers.indexOf(usert[0] * 10) + Number(usert[1]);

            var room_min_tier_score = getTierScore(room_rows[0].tier_min);
            var room_max_tier_score = getTierScore(room_rows[0].tier_max);
            var user_tier_score = getTierScore(user_rows[0].tier);
            
            var room_id = room_rows[0].id;
            var user_room_id = user_rows[0].room_id;
            
            var room_people_now = room_rows[0].people_now;
            var room_people_max = room_rows[0].people_max;
            
            if (room_id !== user_room_id) {
                if (room_people_now < room_people_max) {
                    if (room_min_tier_score <= user_tier_score && user_tier_score <= room_max_tier_score) {
                        mysql.query(`UPDATE Room SET people_now=? updated_at=NOW() WHERE name=?`,
                        [room_people_now + 1, room_name], function(error, update_room_rows, update_room_fields){
                            if(error){
                                throw error;
                            }
                            console.log('db room update', update_room_rows);

                            mysql.query(`UPDATE User SET room_id=? update_at=NOW() WHERE name=?`, 
                            [room_rows[0].id, user_name], function(error, update_user_rows, update_user_fields){
                                if(error){
                                    throw error;
                                }
                                console.log('db user update', update_user_rows);
                                res.writeHead(200);
                                res.end();
                            });
                        });
                    }
                    else {
                        console.log('Tier doesn\'t match', room_rows);
                    }
                }
                
                else {
                    console.log('Room is full', room_rows);
                }
            }
            else {
                console.log('Already in the room', room_rows);
            }
            res.send(room_rows);
        });
    });

});

module.exports = router;

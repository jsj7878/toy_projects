var createError = require('http-errors');
var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');
var compression = require('compression');
var helmet = require('helmet');
var session = require('express-session');
var logger = require('morgan');

const { createConnection } = require('net');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');


app.use(helmet());
app.use(compression());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: 'asdf%#$rhq',
  resave: false,
  saveUninitialized: true
}));


// var indexRouter = require('./routes/index');
var mainRouter = require('./routes/main')
var userRouter = require('./routes/user');
var roomRouter = require('./routes/room');
// var authRouter = require('./routes/auth');

app.use('/', mainRouter);
app.use('/user', userRouter);
app.use('/room', roomRouter);
// app.use('/auth', authRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

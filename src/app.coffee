express = require 'express'
session = require 'express-session'
redis = require 'redis'
logger = require 'morgan'
bodyParser = require 'body-parser'
cookieParser = require('cookie-parser')
RedisStore = require('connect-redis')(session)

client = redis.createClient()
app = express()
metrics = require './metrics'
users = require './users'
app.set 'port', 1337
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use '/', express.static "#{__dirname}/../public"

app.use session
   store: new RedisStore client:client
   secret: 's3cr3t2'
   saveUninitialized: false
   resave: false
   
app.use logger "tiny"
app.use bodyParser.urlencoded { extended: false }
app.use bodyParser.json()
app.use cookieParser 's3cr3t'

authCheck = (req, res, next) ->
   unless req.session.loggedIn == true
      res.redirect '/login'
   else
      next()
      
app.get '/', authCheck, (req, res) ->
   res.render 'index', {name: req.session.username}
   locals: 
      title: 'Asynchronous Technology Webpage'

app.get '/login', (req, res) ->
   res.render 'login'
   
app.post '/login', (req, res) ->
   users.get req.body.username, req.body.password, (err, data) ->
      if data is null
         res.redirect '/login'
      else
         if data.password
            req.session.loggedIn = true
            req.session.username = data.username
         res.redirect '/'

app.get '/logout', (req, res) ->
   req.session.cookie = null
   req.session.loggedIn = false
   req.session.destroy () ->
      res.redirect '/'
   
app.get '/signup', (req, res) ->
   res.render 'signup'

app.get '/metrics.json', authCheck, (req, res) ->
   res.status(200).json metrics.getAll()

app.get '/metric/:key.json', authCheck, (req, res) ->
   metrics.get req.params.key, (reply) ->
      res.status(200).json reply

app.post '/metric/:id.json', authCheck, (req, res) ->
   metrics.save req.params.id, req.body, (err) ->
      if err then res.status(500).json err
      else res.status(200).send "Metrics saved"

app.listen app.get('port'), () ->
   console.log "listening on #{app.get 'port'}"
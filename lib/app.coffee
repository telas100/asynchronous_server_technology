http = require 'http'
users = require './users'

http.createServer (req, res) ->
   path = req.url.split("/").slice 1,3 
   res.writeHead 200, 'Content-Type': 'application/json'
   if path[0] is "get"
      users.get path[1], (user) ->
         res.end JSON.stringify user
   else if path[0] is "save"
      users.save path[1], (user) ->
         response = 
            id: 10,
            name: user,
            description: 'new user'
         res.end JSON.stringify response
   else
      res.end 200, 'Content-Type': 'application/json'
      res.end 'Wrong path'
.listen 1337, '127.0.0.1'
 
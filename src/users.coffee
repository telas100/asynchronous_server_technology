redis = require 'redis'

module.exports =
   get: (username, password, callback) ->
      client = redis.createClient()
      client.on 'error', callback
      client.get "users:#{username}", (err, reply) ->
         client.quit()
         if err
            callback err, false
         else
            if reply != null
               data = {}
               data.raw = reply.split(':')
               data.username = data.raw[0]
               data.password = data.raw[1]==password
               data.name = data.raw[2]
               data.email = data.raw[3]
               callback null,data
            else
               callback false,false
      
   
   save: (username, password, name, email, callback) ->
      client = redis.createClient()
      client.on 'error', callback
      client.set "users:#{username}", "#{username}:#{password}:#{name}:#{email}", (err, reply) ->
         client.quit()
         if (err)
            console.log err
            callback err, false
         else
            console.log "User saved !"
            callback false,"users:#{username}:#{name}:#{email}"

   remove: (username, callback) -> 
      client = redis.createClient()
      client.on 'error', callback
      console.log "users:#{username}"
      client.del "users:#{username}", (err, reply) ->
         client.quit()
         if err
            console.log err
         else
            callback reply
   
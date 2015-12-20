redis = require 'redis'

module.exports =
   getAll: () ->
      return [
         timestamp: new Date('2015-12-01 10:30 UTC').getTime(),
         value: 26
      ,
         timestamp: new Date('2015-12-01 10:35 UTC').getTime(),
         value: 23
      ,
         timestamp: new Date('2015-12-01 10:40 UTC').getTime(),
         value: 25
      ,
         timestamp: new Date('2015-12-01 10:45 UTC').getTime(),
         value: 22
      ,
         timestamp: new Date('2015-12-01 10:50 UTC').getTime(),
         value: 21
      ,
         timestamp: new Date('2015-12-01 10:55 UTC').getTime(),
         value: 25
      ,
         timestamp: new Date('2015-12-01 11:00 UTC').getTime(),
         value: 26
      ,
         timestamp: new Date('2015-12-01 11:05 UTC').getTime(),
         value: 24
      ,
         timestamp: new Date('2015-12-01 11:10 UTC').getTime(),
         value: 22
      ,
         timestamp: new Date('2015-12-01 11:15 UTC').getTime(),
         value: 23
      ]

   getByKey: (key, callback) ->
      client = redis.createClient()
      client.on 'error', callback
      client.get key, (err, reply) ->
         client.quit()
         if err
            console.log err
            callback err, null
         else
            callback err, reply
            
   getByUser: (user, callback) ->
      client = redis.createClient()
      client.on 'error', callback
      client.keys "metrics:#{user}*", (err, keys) ->
         if err
            console.log err
            callback err, null
         else
            i = 0
            replies = []
            for key in keys
               i++
               client.get key, (err, value) ->
                  replies.push timestamp:parseInt(key.split(':')[3]), value:parseInt(value)
                  if i == keys.length
                     callback null, replies, replies.length==keys.length
      
   save: (id, metrics, callback)->
      client = redis.createClient()
      client.on 'error', callback
      for m in metrics
         {username, timestamp, value} = m
         client.set "metrics:#{username}:#{id}:#{timestamp}", value
      client.quit()
      console.log "Batch saved !"
      callback "metrics:#{username}:#{id}:#{timestamp}", value
      
   remove: (key, callback) ->
      client = redis.createClient()
      client.on 'error', callback
      client.del key (err, reply) ->
         client.quit()
         if err
            console.log err
         else
            callback reply
      
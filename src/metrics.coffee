level = require('./level') "#{__dirname}/../db/metrics"

module.exports =
   get: () ->
      return [
         timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:12
      ,   
         timestamp:(new Date '2013-11-04 14:30 UTC').getTime(), value:15
      ]
   
   save: (id, metrics, callback) ->
      ws = level.createWriteStream()
      ws.on 'error', callback
      ws.on 'close', callback
      for metric in metrics
         {timestamp, value} = metric
         ws.write key: "metric:#{id}:#{timestamp}", value: value
      ws.end()
      
      
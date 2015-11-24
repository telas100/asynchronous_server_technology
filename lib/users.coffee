module.exports =
   save: (name, callback) ->
      callback name
   get: (id, callback) ->
      response =
         id: id
         name: 'admin'
         'description': 'Administrator'
      callback response
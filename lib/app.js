var http = require('http')
var users = require('./users.js')

http.createServer(function (req, res) {
   var path = req.url.split("/").slice(1,3);
   res.writeHead(200, {'Content-Type': 'application/json'});
   if(path[0] == "get"){
      users.get(path[1], function(user) {
         res.end(JSON.stringify(user));
      })
   } else if (path[0] == "save") {
      users.save(path[1], function(user){
         var response = {
            'id' : 10,
            'name' : user,
            'description' : 'new user'
         }
         res.end(JSON.stringify(response));
      })
   } else {
      res.end(200, {'Content-Type': 'text/plain'});
      res.end('Wrond path');
   }
}).listen(1339, '127.0.0.1')


var http = require('http')
var users = require('./src/users.js')

http.createServer(function (req, res) { 
  res.writeHead(200, {'Content-Type': 'text/plain'}); 
  res.end('Hello World\n'); 
}).listen(1337, '127.0.0.1')
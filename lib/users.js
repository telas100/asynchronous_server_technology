module.exports = {
   save: function (name, callback){
      callback(name);
   },
   get: function (id, callback){
      var response = {
         'id' : id,
         'name' : 'admin',
         'description' : 'Administrator'      
      }
      callback(response);
   }  
}
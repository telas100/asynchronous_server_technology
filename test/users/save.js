var should = require('should');
var users = require('../../lib/users');

describe('Save Function Unit Tests',function(){
   it('Should return the saved name', function() {
      users.save("benjamin",function(user) {
         user.should.equal("benjamin");
      })
   })
})
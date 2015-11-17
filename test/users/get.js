var should = require('should');
var users = require('../../lib/users');

describe('Get Function Unit Tests',function(){
   it('Should return the right user.id', function() {
      users.get(110,function(user) {
         user.should.have.property('id',110);
      })
   })
})
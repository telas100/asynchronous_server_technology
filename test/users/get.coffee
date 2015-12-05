should = require 'should'
users = require '../../src/users'

describe 'Get Function Unit Tests', () ->
   it 'Should return the right user.id', () ->
      users.get 110, (user) ->
         user.should.have.property('id',110)
should = require 'should'
users = require '../../lib/users'

describe 'Save Function Unit Tests', () ->
   it 'Should return the saved name', () ->
      users.save "benjamin", (user) ->
         user.should.equal "benjamin"
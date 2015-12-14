should = require 'should'
metrics = require '../../src/metrics'

describe 'Save Function Unit Tests', () ->
   it 'Should return the saved key-value', () ->
      id = 42
      met = [timestamp: new Date('2015-12-01 10:30 UTC').getTime(),value: 26]
      metrics.save id, met, (key, value) ->
         key.should.equal "metrics:#{id}:"+new Date('2015-12-01 10:30 UTC').getTime()
         value.should.equal 26
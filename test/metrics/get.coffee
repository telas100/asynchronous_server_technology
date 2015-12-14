should = require 'should'
metrics = require '../../src/metrics'

describe 'Get Function Unit Tests', () ->
   it 'Should return the right metric.value', () ->
      met = [timestamp: new Date('2015-12-01 10:30 UTC').getTime(),value: 26]
      metrics.get met, (reply) ->
         reply.should.equal 26
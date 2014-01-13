lti = require('./lti')
should = require('should')

describe('lti', ->
	describe('ToolConsumer', -> it('should be exported', -> lti.hasOwnProperty('ToolConsumer').should.be.true))
)

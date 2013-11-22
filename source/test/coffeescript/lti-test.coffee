lti = require('./lti')
should = require('should')

describe('lti', ->
	describe('ToolConsumer', -> it('should be exported', -> lti.hasOwnProperty('ToolConsumer').should.be.true))
	describe('ToolContext', -> it('should be exported', -> lti.hasOwnProperty('ToolContext').should.be.true))
	describe('ToolParameters', -> it('should be exported', -> lti.hasOwnProperty('ToolParameters').should.be.true))
	describe('ToolQueryString', -> it('should be exported', -> lti.hasOwnProperty('ToolQueryString').should.be.true))
)

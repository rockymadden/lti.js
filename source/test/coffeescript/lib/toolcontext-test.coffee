should = require('should')
toolcontext = require('./toolcontext')
_ = require('underscore')

describe('toolcontext', ->
	describe('consumerKey', -> it('should exist', -> _.has(toolcontext, 'consumerKey').should.be.true))
	describe('consumerSecret', -> it('should exist', -> _.has(toolcontext, 'consumerSecret').should.be.true))
	describe('utcOffset', ->
		it('should exist', -> _.has(toolcontext, 'utcOffset').should.be.true)
		it('should default to 0', -> toolcontext.utcOffset.should.equal(0))
	)
	describe('host', -> it('should exist', -> _.has(toolcontext, 'host').should.be.true))
	describe('path', -> it('should exist', -> _.has(toolcontext, 'path').should.be.true))
	describe('port', ->
		it('should exist', -> _.has(toolcontext, 'port').should.be.true)
		it('should default to 443', -> toolcontext.port.should.equal(443))
	)
)

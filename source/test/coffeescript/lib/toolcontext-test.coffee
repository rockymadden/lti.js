should = require('should')
toolcontext = require('./toolcontext')

describe('toolcontext', ->
	describe('consumerKey', -> it('should exist', -> toolcontext.hasOwnProperty('consumerKey').should.be.true))
	describe('consumerSecret', -> it('should exist', -> toolcontext.hasOwnProperty('consumerSecret').should.be.true))
	describe('utcOffset', ->
		it('should exist', -> toolcontext.hasOwnProperty('utcOffset').should.be.true)
		it('should default to 0', -> toolcontext.utcOffset.should.equal(0))
	)
	describe('host', -> it('should exist', -> toolcontext.hasOwnProperty('host').should.be.true))
	describe('path', -> it('should exist', -> toolcontext.hasOwnProperty('path').should.be.true))
	describe('port', ->
		it('should exist', -> toolcontext.hasOwnProperty('port').should.be.true)
		it('should default to 443', -> toolcontext.port.should.equal(443))
	)
	describe('withSession()', ->
		it('should pass a toolconsumer', (done) ->
			toolcontext.withSession((toolconsumer) ->
				toolconsumer.should.not.be.null
				done()
			)
		)
	)
)

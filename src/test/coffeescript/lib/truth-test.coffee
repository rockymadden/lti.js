bilby = require('bilby')
should = require('should')
truth = require('./truth')

describe('truth', ->
	describe('toolcontexty()', ->
		it('should return true when valid', ->
			context = bilby.environment()
				.property('consumerKey', null)
				.property('consumerSecret', null)
				.property('utcOffset', null)
				.property('host', null)
				.property('path', null)
				.property('port', null)

			truth.toolcontexty(context).should.be.true
		)
		it('should return false when invalid', -> truth.toolcontexty({}).should.be.false)
	)
	describe('toolparametery()', ->
		it('should return true when valid', ->
			param = bilby.environment()
				.property('lti_message_type', null)
				.property('lti_version', null)
				.property('resource_link_id', null)

			truth.toolparametery(param).should.be.true
		)
		it('should return false when invalid', -> truth.toolcontexty({}).should.be.false)
	)
	describe('toolquerystringy()', ->
		it('should return true when valid', -> truth.toolquerystringy(bilby.environment()).should.be.true)
		it('should return false when invalid', -> truth.toolquerystringy({}).should.be.false)
	)
)

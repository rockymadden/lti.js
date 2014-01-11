bilby = require('bilby')
should = require('should')
truth = require('./truth')

describe('truth', ->
	describe('existy()', ->
		it('should return false if null', -> truth.existy(null).should.be.false)
		it('should return true if 0', -> truth.existy(0).should.be.true)
		it('should return true if an empty string', -> truth.existy('').should.be.true)
		it('should return true if an empty array', -> truth.existy([]).should.be.true)
		it('should return true if an empty object', -> truth.existy({}).should.be.true)
		it('should return true if true', -> truth.existy(true).should.be.true)
		it('should return true if false', -> truth.existy(false).should.be.true)
	)
	describe('truthy()', ->
		it('should return false if null', -> truth.truthy(null).should.be.false)
		it('should return true if 0', -> truth.truthy(0).should.be.true)
		it('should return true if an empty string', -> truth.truthy('').should.be.true)
		it('should return true if an empty array', -> truth.truthy([]).should.be.true)
		it('should return true if an empty object', -> truth.truthy({}).should.be.true)
		it('should return true if true', -> truth.truthy(true).should.be.true)
		it('should return false if false', -> truth.truthy(false).should.be.false)
	)
	describe('lengthy()', ->
		it('should return false if null', -> truth.lengthy(null).should.be.false)
		it('should return false if 0', -> truth.lengthy(0).should.be.false)
		it('should return false if an empty string', -> truth.lengthy('').should.be.false)
		it('should return false if an empty array', -> truth.lengthy([]).should.be.false)
		it('should return false if an empty object', -> truth.lengthy({}).should.be.false)
		it('should return false if true', -> truth.lengthy(true).should.be.false)
		it('should return false if false', -> truth.lengthy(false).should.be.false)
		it('should return true if a non-empty string', -> truth.lengthy('non').should.be.true)
		it('should return true if a non-empty array', -> truth.lengthy('non').should.be.true)
		it('should return false if a non-empty object', -> truth.lengthy({non: 'non'}).should.be.false)
	)
	describe('environmenty()', ->
		it('should return true when valid', -> truth.environmenty(bilby.environment()).should.be.true)
		it('should return false when invalid', -> truth.environmenty({}).should.be.false)
	)
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

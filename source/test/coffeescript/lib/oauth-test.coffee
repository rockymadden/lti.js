should = require('should')
oauth = require('./oauth')
_ = require('underscore')

describe('oauth', ->
	describe('#nonce()', ->
		it('should return a random 32-digit hexidecimal string', ->
			(typeof oauth.nonce()).should.equal('string')
			/[0-9A-Za-z]/.test(oauth.nonce()).should.be.true
			oauth.nonce().length.should.equal(32)
		)
	)
	describe('#sign()', ->
		it('should return a signature', ->
			params =
				oauth_consumer_key: 'oauth_consumer_key'
				oauth_nonce: oauth.nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			oauth.sign('url', params, 'secret').should.not.be.null
			oauth.sign('url', params, 'secret').should.equal(oauth.sign('url', params, 'secret'))
		)
	)
	describe('#authorization()', ->
		it('should return a map containing all oauth parameters', ->
			auth = oauth.authorization('url', {}, 'key', 'secret')

			_.has(auth, 'lti_version').should.be.false
			_.has(auth, 'oauth_signature').should.be.true
		)
	)
	describe('#stringify()', ->
		it('should return a string representation of an authorization for use in an http header', ->
			oauth.stringify(
				oauth.authorization('url', {}, 'key', 'secret')
			).indexOf('oauth_consumer_key="key",oauth_nonce="').should.equal(0)
		)
	)
)

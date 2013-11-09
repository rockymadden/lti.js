should = require('should')
oauth = require('./oauth').property('consumerKey', 'abc').property('consumerSecret', 'xyz')
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
				oauth_callback: 'about:blank'
				oauth_consumer_key: 'oauth_consumer_key'
				oauth_nonce: oauth.nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			oauth.sign('url', params).should.not.be.null
			oauth.sign('url', params).should.equal(oauth.sign('url', params))
		)
	)
	describe('#apply()', ->
		it('should return a map containing all oauth and original parameters', ->
			params =
				lti_message_type: 'basic-lti-launch-request'
				lti_version: 'LTI-1p0'
			applied = oauth.apply('url', params)

			_.has(applied, 'lti_version').should.be.true
			_.has(applied, 'oauth_signature').should.be.true
		)
	)
)

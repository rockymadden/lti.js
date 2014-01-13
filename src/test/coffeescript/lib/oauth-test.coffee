should = require('should')
oauth = require('./oauth')

describe('oauth', ->
	describe('nonce()', ->
		it('should return some(random 32-digit hexidecimal string)', ->
			/[0-9A-Za-z]{32}/.test(oauth.nonce().getOrElse(null)).should.be.true
		)
	)
	describe('sign()', ->
		it('should return some(string)', ->
			params =
				oauth_callback: 'about:blank'
				oauth_consumer_key: 'oauth_consumer_key'
				oauth_nonce: oauth.nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			oauth.sign('url', params, 'secret').getOrElse('one')
				.should.equal(oauth.sign('url', params, 'secret').getOrElse('two'))
		)
		it('should return none with unknown signature method', ->
			params =
				oauth_callback: 'about:blank'
				oauth_consumer_key: 'oauth_consumer_key'
				oauth_nonce: oauth.nonce()
				oauth_signature_method: 'pandora'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			oauth.sign('url', params, 'secret').getOrElse('none')
				.should.equal('none')
		)
	)
	describe('authorization()', ->
		it('should return some(object)', ->
			auth = oauth.authorization('url', {}, 'key', 'secret').getOrElse({})

			auth.hasOwnProperty('lti_version').should.be.false
			auth.hasOwnProperty('oauth_signature').should.be.true
		)
	)
)

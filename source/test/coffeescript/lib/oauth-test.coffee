should = require('should')
oauth = require('./oauth')

describe('oauth', ->
	describe('base64', ->
		it('should exist', -> oauth.hasOwnProperty('base64').should.be.true)
		it('should default to 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', ->
			oauth.base64.should.equal('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
		)
	)
	describe('utcOffset', ->
		it('should exist', -> oauth.hasOwnProperty('utcOffset').should.be.true)
		it('should default to 0', -> oauth.utcOffset.should.equal(0))
	)
	describe('nonce()', ->
		it('should return a random 32-digit hexidecimal string', ->
			(typeof oauth.nonce()).should.equal('string')
			/[0-9A-Za-z]/.test(oauth.nonce()).should.be.true
			oauth.nonce().length.should.equal(32)
		)
	)
	describe('sign()', ->
		it('should return a string based signature', ->
			params =
				oauth_callback: 'oob'
				oauth_consumer_key: 'oauth_consumer_key'
				oauth_nonce: oauth.nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			oauth.sign('url', params, 'secret').should.not.be.null
			oauth.sign('url', params, 'secret').should.equal(oauth.sign('url', params, 'secret'))
		)
	)
	describe('authorization()', ->
		it('should return an immutable environment containing all oauth parameters', ->
			auth = oauth.authorization('url', {}, 'key', 'secret')

			auth.hasOwnProperty('lti_version').should.be.false
			auth.hasOwnProperty('oauth_signature').should.be.true
		)
	)
)

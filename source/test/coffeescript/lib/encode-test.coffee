should = require('should')
encode = require('./encode')
oauth = require('./oauth')

describe('encode', ->
	describe('httpAuthorizationHeader()', ->
		it('should return a string representation of an authorization for use in an http header', ->
			encode.httpAuthorizationHeader(
				oauth.authorization('url', {}, 'key', 'secret')
			).indexOf('oauth_callback="oob",oauth_consumer_key="key",oauth_nonce="').should.equal(0)
		)
	)
	describe('url()', ->
		it('should return a string representation of a map fit for a url and post data', ->
			encode.url(
				test1: 'test1'
				test2: 'test2'
			).indexOf('test1=test1&test2=test2').should.equal(0)
		)
	)
)

should = require('should')
encode = require('./encode')
oauth = require('./oauth')

describe('encode', ->
	describe('httpAuthorizationHeader()', ->
		it('should return some(string representation of an authorization)', ->
			encode.httpAuthorizationHeader(oauth.authorization('url', {}, 'key', 'secret').getOrElse('')).getOrElse('')
				.indexOf('oauth_callback="about%3Ablank",oauth_consumer_key="key",oauth_nonce="')
				.should.equal(0)
		)
	)
	describe('rfc3986()', ->
		it('should return some(RFC 3986 compatible string)', ->
			encode.rfc3986('hello there!').getOrElse('')
				.should.equal('hello%20there%21')
		)
	)
	describe('url()', ->
		it('should return some(string representation of a map)', ->
			encode.url(test1: 'test1', test2: 'test2').getOrElse('')
				.should.equal('test1=test1&test2=test2')
		)
	)
)

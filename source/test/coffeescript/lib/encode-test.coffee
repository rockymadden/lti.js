should = require('should')
encode = require('./encode')
oauth = require('./oauth')

describe('encode', ->
	describe('defunc()', ->
		it('should return a map with keys which had function values removed', ->
			Object.keys(encode.defunc(nonfunc: 'nonfunc', func: ((test) ->))).length.should.equal(1)
		)
	)
	describe('httpAuthorizationHeader()', ->
		it('should return a string representation of an authorization for use in an http header', ->
			encode.httpAuthorizationHeader(
				oauth.authorization('url', {}, 'key', 'secret')
			).indexOf('oauth_callback="about%3Ablank",oauth_consumer_key="key",oauth_nonce="').should.equal(0)
		)
	)
	describe('rfc3986()', ->
		it('should return a RFC 3986 compatible string', ->
			encode.rfc3986('hello there!').should.equal('hello%20there%21')
		)
	)
	describe('url()', ->
		it('should return a string representation of a map fit for a url and post data', ->
			encode.url(test1: 'test1', test2: 'test2').should.equal('test1=test1&test2=test2')
		)
	)
)

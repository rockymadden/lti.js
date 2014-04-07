should = require('should')
encode = require('./encode')

describe('encode', ->
	describe('rfc3986()', ->
		it('should return RFC 3986 compatible string', ->
			encode.rfc3986('hello there!').should.equal('hello%20there%21')
		)
	)
	describe('url()', ->
		it('should return string representation of a map', ->
			encode.url(test2: 'test2', test1: 'test1').should.equal('test1=test1&test2=test2')
		)
	)
)

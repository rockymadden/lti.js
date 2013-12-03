bilby = require('bilby')
convert = require('./convert')
should = require('should')

describe('convert', ->
	describe('toMap()', ->
		it('should return a map', ->
			map = convert.toMap(bilby.environment().property('test', 'test'))

			Object.keys(map).length.should.equal(1)
			map.hasOwnProperty('test').should.be.true
		)
	)
	describe('toEnvironment()', ->
		it('should return an environment', ->
			environment = convert.toEnvironment(test: 'test')

			Object.keys(environment).length.should.be.above(1)
			environment.hasOwnProperty('test').should.be.true
		)
	)
)

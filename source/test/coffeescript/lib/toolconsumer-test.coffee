config = require('../etc/toolconsumer-test.config')
should = require('should')
oauth = require('./oauth')
toolconsumer = require('./toolconsumer')

describe('toolconsumer', ->
	describe('request(), a multimethod, without toolcontext', ->
		it('should return an option monad holding the response', (done) ->
			params = require('./toolparameters').property('resource_link_id', '0')
			context = require('./toolcontext')
				.property('consumerKey', config.consumerKey)
				.property('consumerSecret', config.consumerSecret)
				.property('host', config.host)
				.property('path', config.path)
				.property('port', config.port)

			(toolconsumer.property('toolcontext', context)).request(params).then((response) ->
				response.isSome.should.be.true
				response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
				done()
			)
		)
	)
)

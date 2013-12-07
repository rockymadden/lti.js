config = require('../etc/toolconsumer-test.config')
should = require('should')
oauth = require('./oauth')
toolconsumer = require('./toolconsumer')

describe('toolconsumer', ->
	describe('request()', ->
		it('should return an option monad holding the response when passed bilby environment(s)', (done) ->
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
		it('should return an option monad holding the response when passed map(s)', (done) ->
			context = require('./toolcontext')
				.property('consumerKey', config.consumerKey)
				.property('consumerSecret', config.consumerSecret)
				.property('host', config.host)
				.property('path', config.path)
				.property('port', config.port)

			(toolconsumer.property('toolcontext', context))
				.request(
					lti_version: 'LTI-1p0'
					lti_message_type: 'basic-lti-launch-request'
					resource_link_id: '0'
				).then((response) ->
					response.isSome.should.be.true
					response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
					done()
				)
		)
	)
)

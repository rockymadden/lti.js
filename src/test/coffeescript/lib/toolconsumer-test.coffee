should = require('should')
oauth = require('./oauth')
toolconsumer = require('./toolconsumer')

describe('toolconsumer', ->
	describe('request()', ->
		it('should return an option monad holding the response when passed bilby environment(s)', (done) ->
			params = require('./toolparameters').property('resource_link_id', '0')
			context = require('./toolcontext')
				.property('consumerKey', process.env.LTIJS_CONSUMERKEY)
				.property('consumerSecret', process.env.LTIJS_CONSUMERSECRET)
				.property('host', process.env.LTIJS_HOST)
				.property('path', process.env.LTIJS_PATH)
				.property('port', process.env.LTIJS_PORT)

			(toolconsumer.property('toolcontext', context)).request(params).then((response) ->
				response.isSome.should.be.true
				response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
				done()
			)
		)
		it('should return an option monad holding the response when passed map(s)', (done) ->
			context = require('./toolcontext')
				.property('consumerKey', process.env.LTIJS_CONSUMERKEY)
				.property('consumerSecret', process.env.LTIJS_CONSUMERSECRET)
				.property('host', process.env.LTIJS_HOST)
				.property('path', process.env.LTIJS_PATH)
				.property('port', process.env.LTIJS_PORT)

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

should = require('should')
toolconsumer = require('./toolconsumer')

describe('ToolConsumer', ->
	describe('withSession() post()', ->
		it('should return some', (done) ->
			context = new toolconsumer.ToolConsumer(
				process.env.LTIJS_HOST,
				process.env.LTIJS_PORT,
				process.env.LTIJS_PATH,
				process.env.LTIJS_CONSUMERKEY,
				process.env.LTIJS_CONSUMERSECRET
			)

			context.withSession((session) ->
				parameters =
					lti_version: 'LTI-1p0'
					lti_message_type: 'basic-lti-launch-request'
					resource_link_id: '0'

				session.post(parameters)
					.then((response) ->
						response.isSome.should.be.true
						response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
						done()
					)
			)
		)
	)
)

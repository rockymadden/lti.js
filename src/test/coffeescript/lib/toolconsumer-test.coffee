should = require('should')
ToolConsumer = require('./toolconsumer')

describe('ToolConsumer', ->
	describe('withSession() post()', ->
		it('should return some with valid arguments', (done) ->
			consumer = new ToolConsumer(
				process.env.LTIJS_URL,
				process.env.LTIJS_CONSUMERKEY,
				process.env.LTIJS_CONSUMERSECRET
			)

			consumer.withSession((session) ->
				payload =
					lti_version: 'LTI-1p0'
					lti_message_type: 'basic-lti-launch-request'
					resource_link_id: '0'

				session.basicLaunch(payload)
					.then((response) ->
						response.isSome.should.be.true
						response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
					).done(-> done())
			)
		)
	)
)

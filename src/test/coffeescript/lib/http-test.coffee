Http = require('./http')
should = require('should')

http = new Http(
	process.env.LTIJS_URL,
	process.env.LTIJS_CONSUMERKEY,
	process.env.LTIJS_CONSUMERSECRET
)

describe('Http', ->
	describe('post()', ->
		it('should work', (done) ->
			payload =
				lti_version: 'LTI-1p0'
				lti_message_type: 'basic-lti-launch-request'
				resource_link_id: '0'

			http.post(payload)
				.then((response) ->
					response.isSome.should.be.true
					response.getOrElse('').indexOf('Context Information:').should.be.above(-1)
				).done(-> done())
		)
	)
)

config = require('../etc/toolconsumer.config')
should = require('should')
oauth = require('./oauth')
toolconsumer = require('./toolconsumer')
_ = require('underscore')

describe('toolconsumer', ->
	describe('basicRequest()', ->
		it('should return an option monad holding the response', (done) ->
			formParams =
				lti_message_type: 'basic-lti-launch-request'
				lti_version: 'LTI-1p0'
				resource_link_id: '429785226'
			context = require('./toolcontext')
				.property('consumerKey', config.consumerKey)
				.property('consumerSecret', config.consumerSecret)
				.property('host', config.host)
				.property('path', config.path)
				.property('port', config.port)

			toolconsumer.request(context, formParams, {}).then((response) ->
				console.dir(response.getOrElse('')) # TODO: Not currently working with netTrekker.
				done()
			)
		)
	)
)

config = require('../etc/toolconsumer.config')
should = require('should')
oauth = require('./oauth')
toolconsumer = require('./toolconsumer')
	.property('consumerKey', config.consumerKey)
	.property('consumerSecret', config.consumerSecret)
	.property('host', config.host)
	.property('path', config.path)
	.property('port', config.port)
_ = require('underscore')

describe('toolconsumer', ->
	describe('#basicRequest()', ->
		it('should return a random 32-digit hexidecimal string', (done) ->
			formParams =
				lti_message_type: 'basic-lti-launch-request'
				lti_version: 'LTI-1p0'

			toolconsumer.basicRequest(formParams, {}).then((response) ->
				#console.dir response.getOrElse('') # TODO: Not currently working with netTrekker.
				done()
			)
		)
	)
)

bilby = require('bilby')

toolparameters = bilby.environment()
	.property('lti_message_type', 'basic-lti-launch-request')
	.property('lti_version', 'LTI-1p0')
	.property('resource_link_id', null)

module.exports = toolparameters

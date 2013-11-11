bilby = require('bilby')

toolcontext = bilby.environment()
	.property('consumerKey', null)
	.property('consumerSecret', null)
	.property('host', null)
	.property('path', null)
	.property('port', null)

module.exports = toolcontext

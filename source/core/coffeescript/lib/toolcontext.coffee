bilby = require('bilby')
toolconsumer = require('./toolconsumer')

toolcontext = bilby.environment()
	.property('consumerKey', null)
	.property('consumerSecret', null)
	# In hours, positive or negative.
	.property('utcOffset', 0)
	.property('host', null)
	.property('path', null)
	.property('port', 443)
	.method('withSession',
		((callback) -> bilby.isFunction(callback)),
		((callback) -> callback(toolconsumer.property('toolcontext', @)))
	)

module.exports = toolcontext

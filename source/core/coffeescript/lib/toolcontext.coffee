bilby = require('bilby')

toolcontext = bilby.environment()
	.property('consumerKey', null)
	.property('consumerSecret', null)
	# In hours, positive or negative.
	.property('utcOffset', 0)
	.property('host', null)
	.property('path', null)
	.property('port', 443)

module.exports = toolcontext

bilby = require('bilby')
truthy = require('truthy.js')

truth = bilby.environment()
	.property('signedOAuthy', ((a) ->
		truthy.bool.existy(a) and
		a.hasOwnProperty('oauth_callback') and a.hasOwnProperty('oauth_consumer_key') and
		a.hasOwnProperty('oauth_nonce') and a.hasOwnProperty('oauth_timestamp') and
		a.hasOwnProperty('oauth_signature_method') and a.hasOwnProperty('oauth_version') and
		a.hasOwnProperty('oauth_signature')
	))
	.property('toolcontexty', ((a) ->
		truthy.bool.environmenty(a) and
		a.hasOwnProperty('consumerKey') and a.hasOwnProperty('consumerSecret') and
		a.hasOwnProperty('utcOffset') and a.hasOwnProperty('host') and
		a.hasOwnProperty('path') and a.hasOwnProperty('port')
	))
	.property('toolparametery', ((a) ->
		truthy.bool.environmenty(a) and
		a.hasOwnProperty('lti_message_type') and
		a.hasOwnProperty('lti_version') and
		a.hasOwnProperty('resource_link_id')
	))
	.property('toolquerystringy', ((a) ->
		truthy.bool.environmenty(a)
	))
	.property('unsignedOAuthy', ((a) ->
		truthy.bool.existy(a) and
		a.hasOwnProperty('oauth_callback') and a.hasOwnProperty('oauth_consumer_key') and
		a.hasOwnProperty('oauth_nonce') and a.hasOwnProperty('oauth_timestamp') and
		a.hasOwnProperty('oauth_signature_method') and a.hasOwnProperty('oauth_version')
	))

module.exports = truth

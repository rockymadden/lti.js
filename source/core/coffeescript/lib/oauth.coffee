bilby = require('bilby')
oauthsign = require('oauth-sign')
_ = require('underscore')

oauth = bilby.environment()
	.property('configuration', {oauth_consumer_key: null, oauth_consumer_secret: null})
	.property('nonceChars', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
	.method('apply',
		((url, parameters) ->
			bilby.isString(url) and
			typeof parameters is 'object' and
			_.has(parameters, 'lti_message_type') and
			_.has(parameters, 'lti_version')
		),
		((url, parameters) ->
			oauthParameters =
				oauth_callback: 'about:blank'
				oauth_consumer_key: @configuration.oauth_consumer_key
				oauth_nonce: @nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'
			mergedParameters = bilby.extend(parameters, oauthParameters)

			bilby.extend(mergedParameters, oauth_signature: @sign(url, mergedParameters))
		)
	)
	.method('sign',
		((url, parameters) ->
			bilby.isString(url) and
			typeof parameters is 'object' and
			_.has(parameters, 'oauth_consumer_key') and
			_.has(parameters, 'oauth_nonce') and
			_.has(parameters, 'oauth_timestamp') and
			_.has(parameters, 'oauth_signature_method') and
			_.has(parameters, 'oauth_version')
		),
		((url, parameters) -> switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				oauthsign.hmacsign('POST', url, parameters, @configuration.oauth_consumer_secret)
			else throw 'Expected supported signature method.'
		)
	)
	.method('nonce', (-> true), (->
		self = @
		_.map([0..31], -> self.nonceChars[Math.floor(Math.random() * self.nonceChars.length)]).join('')
	))

module.exports = oauth

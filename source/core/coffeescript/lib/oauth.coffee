bilby = require('bilby')
oauthsign = require('oauth-sign')
_ = require('underscore')

oauth = bilby.environment()
	.property('base64', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
	.property('consumerKey', null)
	.property('consumerSecret', null)
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
				oauth_consumer_key: @consumerKey
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
				oauthsign.hmacsign('POST', url, parameters, @consumerSecret)
			else throw 'Expected supported signature method.'
		)
	)
	.method('nonce', (-> true), (->
		self = @
		_.map([0..31], -> self.base64[Math.floor(Math.random() * self.base64.length)]).join('')
	))

module.exports = oauth

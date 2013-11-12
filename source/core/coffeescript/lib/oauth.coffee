bilby = require('bilby')
oauthsign = require('oauth-sign')
_ = require('underscore')

oauth = bilby.environment()
	.property('base64', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
	.method('authorization',
		((url, parameters, consumerKey, consumerSecret) -> url? and parameters? and consumerKey? and consumerSecret?),
		((url, parameters, consumerKey, consumerSecret) ->
			oauthParameters =
				oauth_callback: 'oob'
				oauth_consumer_key: consumerKey
				oauth_nonce: @nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			bilby.environment()
				.property('oauth_callback', oauthParameters.oauth_callback)
				.property('oauth_consumer_key', oauthParameters.oauth_consumer_key)
				.property('oauth_nonce', oauthParameters.oauth_nonce)
				.property('oauth_signature', @sign(url, bilby.extend(parameters, oauthParameters), consumerSecret))
				.property('oauth_signature_method', oauthParameters.oauth_signature_method)
				.property('oauth_timestamp', oauthParameters.oauth_timestamp)
				.property('oauth_version', oauthParameters.oauth_version)
		)
	)
	.method('nonce', (-> true), (->
		self = @
		_.map([0..31], -> self.base64[Math.floor(Math.random() * self.base64.length)]).join('')
	))
	.method('sign',
		((url, parameters, consumerSecret) ->
			url? and parameters? and consumerSecret? and
			_.has(parameters, 'oauth_callback') and _.has(parameters, 'oauth_consumer_key') and
			_.has(parameters, 'oauth_nonce') and _.has(parameters, 'oauth_timestamp') and
			_.has(parameters, 'oauth_signature_method') and _.has(parameters, 'oauth_version')
		),
		((url, parameters, consumerSecret) -> switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				oauthsign.hmacsign('POST', url, parameters, consumerSecret)
			else throw 'Expected supported signature method.'
		)
	)

module.exports = oauth

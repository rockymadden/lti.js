bilby = require('bilby')
oauthsign = require('oauth-sign')
_ = require('underscore')

oauth = bilby.environment()
	.property('base64', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
	.method('authorization',
		((url, parameters, consumerKey, consumerSecret) ->
			bilby.isString(url) and parameters? and typeof parameters is 'object' and
			consumerKey? and bilby.isString(consumerKey) and consumerSecret? and bilby.isString(consumerSecret)
		),
		((url, parameters, consumerKey, consumerSecret) ->
			oauthParameters =
				oauth_callback: 'oob'
				oauth_consumer_key: consumerKey
				oauth_nonce: @nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now()
				oauth_version: '1.0'

			bilby.extend(
				oauthParameters,
				oauth_signature: @sign(url, bilby.extend(parameters, oauthParameters), consumerSecret)
			)
		)
	)
	.method('nonce', (-> true), (->
		self = @
		_.map([0..31], -> self.base64[Math.floor(Math.random() * self.base64.length)]).join('')
	))
	.method('sign',
		((url, parameters, consumerSecret) ->
			bilby.isString(url) and parameters? and typeof parameters is 'object' and
			_.has(parameters, 'oauth_callback') and _.has(parameters, 'oauth_consumer_key') and
			_.has(parameters, 'oauth_nonce') and _.has(parameters, 'oauth_timestamp') and
			_.has(parameters, 'oauth_signature_method') and _.has(parameters, 'oauth_version') and
			consumerSecret? and bilby.isString(consumerSecret)
		),
		((url, parameters, consumerSecret) -> switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				oauthsign.hmacsign('POST', url, parameters, consumerSecret)
			else throw 'Expected supported signature method.'
		)
	)
	.method('stringify',
		((authorization) ->
			authorization? and typeof authorization is 'object' and Object.keys(authorization).length is 7 and
			_.has(authorization, 'oauth_callback') and _.has(authorization, 'oauth_consumer_key') and
			_.has(authorization, 'oauth_nonce') and _.has(authorization, 'oauth_timestamp') and
			_.has(authorization, 'oauth_signature') and _.has(authorization, 'oauth_signature_method') and
			_.has(authorization, 'oauth_version')
		),
		((authorization) -> _.map(authorization, (v, k) -> k + '="' + encodeURIComponent(v.toString()) + '"').join(','))
	)

module.exports = oauth

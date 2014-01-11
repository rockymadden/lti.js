bilby = require('bilby')
convert = require('./convert')
lazy = require('lazy.js')
oauthsign = require('oauth-sign')
truth = require('./truth')
truthy = require('truthy-js')

oauth = bilby.environment()
	.property('nonce', (->
		base64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

		lazy([0..31]).map(-> base64[Math.floor(Math.random() * base64.length)]).toArray().join('')
	))
	.property('utcOffset', 0)
	.method('authorization',
		((url, parameters, consumerKey, consumerSecret) ->
			truthy.bool.existy(url) and truthy.bool.existy(parameters) and
			truthy.bool.existy(consumerKey) and truthy.bool.existy(consumerSecret)
		),
		((url, parameters, consumerKey, consumerSecret) ->
			oauthParameters =
				oauth_callback: 'about:blank'
				oauth_consumer_key: consumerKey
				oauth_nonce: @nonce()
				oauth_signature_method: 'HMAC-SHA1'
				oauth_timestamp: Date.now() + (@utcOffset * (60 * 60 * 1000))
				oauth_version: '1.0'

			bilby.environment()
				.property('oauth_callback', oauthParameters.oauth_callback)
				.property('oauth_consumer_key', oauthParameters.oauth_consumer_key)
				.property('oauth_nonce', oauthParameters.oauth_nonce)
				.property('oauth_signature', @sign(
					url,
					bilby.extend(
						truthy.opt.environmenty(parameters).map((i) -> convert.toMap(i)).getOrElse(parameters),
						oauthParameters
					),
					consumerSecret
				))
				.property('oauth_signature_method', oauthParameters.oauth_signature_method)
				.property('oauth_timestamp', oauthParameters.oauth_timestamp)
				.property('oauth_version', oauthParameters.oauth_version)
		)
	)
	.method('sign',
		((url, parameters, consumerSecret) ->
			truthy.bool.existy(url) and truthy.bool.existy(parameters) and
			truthy.bool.existy(consumerSecret) and truth.unsignedOAuthy(parameters)
		),
		((url, parameters, consumerSecret) -> switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				oauthsign.hmacsign(
					'POST',
					url,
					truthy.opt.environmenty(parameters).map((e) -> convert.toMap(e)).getOrElse(parameters),
					consumerSecret
				)
			else throw 'Expected supported signature method.'
		)
	)

module.exports = oauth

bilby = require('bilby')
convert = require('./convert')
func = require('./func')
oauthsign = require('oauth-sign')
_ = require('underscore')

oauth = bilby.environment()
	.property('base64', '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
	.property('utcOffset', 0)
	.method('authorization',
		((url, parameters, consumerKey, consumerSecret) ->
			func.existy(url) and func.existy(parameters) and
			func.existy(consumerKey) and func.existy(consumerSecret)
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
						(if func.environmenty(parameters) then convert.toMap(parameters) else parameters),
						oauthParameters
					),
					consumerSecret
				))
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
			func.existy(url) and func.existy(parameters) and
			func.existy(consumerSecret) and func.unsignedOAuthy(parameters)
		),
		((url, parameters, consumerSecret) -> switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				oauthsign.hmacsign(
					'POST',
					url,
					(if func.environmenty(parameters) then convert.toMap(parameters) else parameters),
					consumerSecret
				)
			else throw 'Expected supported signature method.'
		)
	)

module.exports = oauth

bilby = require('bilby')
lazy = require('lazy.js')
oauthsign = require('oauth-sign')
truthy = require('truthy.js')

oauth =
	authorization: (url, parameters, consumerKey, consumerSecret, utcOffset) ->
		oauthParameters =
			oauth_callback: 'about:blank'
			oauth_consumer_key: consumerKey
			oauth_nonce: oauth.nonce().getOrElse(null)
			oauth_signature_method: 'HMAC-SHA1'
			oauth_timestamp: Date.now() + (utcOffset * (60 * 60 * 1000))
			oauth_version: '1.0'

		oauth.sign(url, lazy(parameters).extend(oauthParameters).toObject(), consumerSecret).map((s) -> Object.freeze(
			oauth_callback: oauthParameters.oauth_callback
			oauth_consumer_key: oauthParameters.oauth_consumer_key
			oauth_nonce: oauthParameters.oauth_nonce
			oauth_signature: s
			oauth_signature_method: oauthParameters.oauth_signature_method
			oauth_timestamp: oauthParameters.oauth_timestamp
			oauth_version: oauthParameters.oauth_version
		))

	nonce: ->
		bilby.some(lazy([0..31]).map(->
			base64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
			base64[Math.floor(Math.random() * base64.length)]
		).toArray().join(''))

	sign: (url, parameters, consumerSecret) ->
		switch parameters.oauth_signature_method
			when 'HMAC-SHA1'
				bilby.some(oauthsign.hmacsign('POST', url, parameters, consumerSecret))
			else bilby.none

module.exports = Object.freeze(oauth)

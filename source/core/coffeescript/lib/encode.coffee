bilby = require('bilby')
_ = require('underscore')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) ->
			authorization? and
			_.has(authorization, 'oauth_callback') and _.has(authorization, 'oauth_consumer_key') and
			_.has(authorization, 'oauth_nonce') and _.has(authorization, 'oauth_timestamp') and
			_.has(authorization, 'oauth_signature') and _.has(authorization, 'oauth_signature_method') and
			_.has(authorization, 'oauth_version')
		),
		((authorization) -> _.chain(authorization)
			.omit(
				_.chain(authorization)
					.map((v, k) -> if (k.indexOf('oauth_') is -1) then k else null).filter((i) -> i?).value()
			)
			.map((v, k) -> k + '="' + encodeURIComponent(v.toString()) + '"')
			.value()
			.join(','))
	)
	.method('url',
		((map) -> map?),
		((map) -> _.chain(map)
			.omit(
				_.chain(map)
					.map((v, k) -> if (v? and typeof v is 'function') then k else null).filter((i) -> i?).value()
			)
			.map((v, k) -> encodeURIComponent(k) + '=' + encodeURIComponent(v.toString()))
			.value()
			.join('&'))
	)

module.exports = encode

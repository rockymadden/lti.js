bilby = require('bilby')
_ = require('underscore')

encode = bilby.environment()
	.method('httpPostData',
		((map) -> map?),
		((map) -> _.map(map, (v, k) -> encodeURIComponent(k) + '=' + encodeURIComponent(v.toString())).join('&'))
	)
	.method('httpAuthorizationHeader',
		((authorization) ->
			authorization? and
			_.has(authorization, 'oauth_callback') and _.has(authorization, 'oauth_consumer_key') and
			_.has(authorization, 'oauth_nonce') and _.has(authorization, 'oauth_timestamp') and
			_.has(authorization, 'oauth_signature') and _.has(authorization, 'oauth_signature_method') and
			_.has(authorization, 'oauth_version')
		),
		((authorization) ->
			_.chain(authorization)
				.map((v, k) -> k + '="' + encodeURIComponent(v.toString()) + '"')
				.filter((i) -> i.indexOf('oauth_') != -1)
				.value()
				.join(',')
		)
	)


module.exports = encode

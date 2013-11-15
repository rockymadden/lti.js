bilby = require('bilby')
func = require('./func')
_ = require('underscore')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) -> func.signedOAuthy(authorization)),
		((authorization) -> _.chain(authorization)
			.omit(
				_.chain(authorization)
					.map((v, k) -> if (k.indexOf('oauth_') is -1) then k else null)
					.filter((i) -> func.existy(i))
					.value()
			)
			.map((v, k) -> k + '="' + encodeURIComponent(v.toString()) + '"')
			.value()
			.join(','))
	)
	.method('url',
		((map) -> func.existy(map)),
		((map) -> _.chain(map)
			.omit(
				_.chain(map)
					.map((v, k) -> if (func.existy(v) and typeof v is 'function') then k else null)
					.filter((i) -> func.existy(i))
					.value()
			)
			.map((v, k) -> encodeURIComponent(k) + '=' + encodeURIComponent(v.toString()))
			.value()
			.join('&'))
	)

module.exports = encode

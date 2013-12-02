bilby = require('bilby')
func = require('./func')
_ = require('underscore')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) -> func.signedOAuthy(authorization)),
		((authorization) ->
			self = @
			_.map(func.defunc(authorization), (v, k) -> k + '="' + self.rfc3986(v.toString()) + '"').join(','))
	)
	.method('rfc3986',
		((string) -> func.existy(string)),
		((string) -> encodeURIComponent(string)
			.replace(/!/g, '%21').replace(/\*/g, '%2A').replace(/\(/g, '%28').replace(/\)/g, '%29').replace(/'/g, '%27')
		)
	)
	.method('url',
		((map) -> func.existy(map)),
		((map) ->
			self = @
			_.map(func.defunc(map), (v, k) -> self.rfc3986(k) + '=' + self.rfc3986(v.toString())).join('&'))
	)

module.exports = encode

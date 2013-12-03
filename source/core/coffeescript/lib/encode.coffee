bilby = require('bilby')
convert = require('./convert')
truth = require('./truth')
_ = require('underscore')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) -> truth.signedOAuthy(authorization)),
		((authorization) ->
			self = @
			_.map(
				(if truth.environmenty(authorization) then convert.toMap(authorization) else authorization),
				(v, k) -> k + '="' + self.rfc3986(v.toString()) + '"').join(',')
			)
	)
	.method('rfc3986',
		((string) -> truth.existy(string)),
		((string) -> encodeURIComponent(string)
			.replace(/!/g, '%21').replace(/\*/g, '%2A').replace(/\(/g, '%28').replace(/\)/g, '%29').replace(/'/g, '%27')
		)
	)
	.method('url',
		((map) -> truth.existy(map)),
		((map) ->
			self = @
			_.map(
				(if truth.environmenty(map) then convert.toMap(map) else map),
				(v, k) -> self.rfc3986(k) + '=' + self.rfc3986(v.toString())).join('&')
			)
	)

module.exports = encode

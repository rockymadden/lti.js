bilby = require('bilby')
convert = require('./convert')
lazy = require('lazy.js')
truth = require('./truth')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) -> truth.signedOAuthy(authorization)),
		((authorization) ->
			self = @
			lazy((if truth.environmenty(authorization) then convert.toMap(authorization) else authorization)).map(
				(v, k) -> k + '="' + self.rfc3986(v.toString()) + '"'
			).toArray().join(',')
		)
	)
	.method('rfc3986',
		((string) -> truth.existy(string)),
		((string) ->
			encodeURIComponent(string)
				.replace(/!/g, '%21')
				.replace(/\*/g, '%2A')
				.replace(/\(/g, '%28')
				.replace(/\)/g, '%29')
				.replace(/'/g, '%27')
		)
	)
	.method('url',
		((map) -> truth.existy(map)),
		((map) ->
			self = @
			lazy((if truth.environmenty(map) then convert.toMap(map) else map)).map(
				(v, k) -> self.rfc3986(k) + '=' + self.rfc3986(v.toString())
			).toArray().join('&')
		)
	)

module.exports = encode

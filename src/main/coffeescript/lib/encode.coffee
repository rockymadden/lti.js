bilby = require('bilby')
convert = require('./convert')
lazy = require('lazy.js')
truth = require('./truth')
truthy = require('truthy-js')

encode = bilby.environment()
	.method('httpAuthorizationHeader',
		((authorization) -> truth.signedOAuthy(authorization)),
		((authorization) ->
			self = @

			lazy(truthy.opt.environmenty(authorization).map((e) -> convert.toMap(e)).getOrElse(authorization))
				.map((v, k) -> k + '="' + self.rfc3986(v.toString()) + '"')
				.toArray()
				.join(',')
		)
	)
	.method('rfc3986',
		((string) -> truthy.bool.existy(string)),
		((string) -> encodeURIComponent(string)
			.replace(/!/g, '%21')
			.replace(/\*/g, '%2A')
			.replace(/\(/g, '%28')
			.replace(/\)/g, '%29')
			.replace(/'/g, '%27')
		)
	)
	.method('url',
		((map) -> truthy.bool.existy(map)),
		((map) ->
			self = @

			lazy(truthy.opt.environmenty(map).map((e) -> convert.toMap(e)).getOrElse(map))
				.map((v, k) -> self.rfc3986(k) + '=' + self.rfc3986(v.toString()))
				.toArray()
				.join('&')
		)
	)

module.exports = encode

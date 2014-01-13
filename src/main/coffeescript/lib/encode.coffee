lazy = require('lazy.js')
truthy = require('truthy.js')

encode =
	httpAuthorizationHeader: (authorization) -> truthy.opt.objecty(authorization).map((a) ->
		lazy(a)
			.map((v, k) -> k + '="' + encode.rfc3986(v.toString()).getOrElse('') + '"')
			.toArray()
			.join(',')
	)

	rfc3986: (string) -> truthy.opt.stringy(string).map((s) ->
		encodeURIComponent(s)
			.replace(/!/g, '%21')
			.replace(/\*/g, '%2A')
			.replace(/\(/g, '%28')
			.replace(/\)/g, '%29')
			.replace(/'/g, '%27')
	)

	url: (map) -> truthy.opt.objecty(map).map((m) ->
		lazy(m)
			.map((v, k) ->
				encode.rfc3986(k.toString()).getOrElse('') + '=' + encode.rfc3986(v.toString()).getOrElse('')
			)
			.toArray()
			.join('&')
	)

module.exports = Object.freeze(encode)

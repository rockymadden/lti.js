lazy = require('lazy.js')
truthy = require('truthy.js')

encode =
	httpAuthorizationHeader: (a) -> truthy.opt.objecty(a).map((_) ->
		lazy(_)
			.map((v, k) -> k + encode.rfc3986(v.toString()).map((_) -> '="' + _ + '"').getOrElse(''))
			.toArray()
			.join(',')
	)

	rfc3986: (s) -> truthy.opt.stringy(s).map((_) ->
		encodeURIComponent(_)
			.replace(/!/g, '%21')
			.replace(/\*/g, '%2A')
			.replace(/\(/g, '%28')
			.replace(/\)/g, '%29')
			.replace(/'/g, '%27')
	)

	url: (m) -> truthy.opt.objecty(m).map((_) ->
		lazy(_)
			.map((v, k) ->
				encode.rfc3986(k.toString()).getOrElse('') +
				encode.rfc3986(v.toString()).map((_) ->  '=' + _).getOrElse('')
			)
			.toArray()
			.join('&')
	)

module.exports = Object.freeze(encode)

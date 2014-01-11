bilby = require('bilby')
lazy = require('lazy.js')
truthy = require('truthy.js')

convert = bilby.environment()
	.method('toMap',
		((environment) -> truthy.bool.environmenty(environment)),
		((environment) -> lazy(environment).omit(
			lazy(environment)
				.map((v, k) -> truthy.opt.functiony(v).map(-> k).getOrElse(null))
				.filter((i) -> truthy.bool.existy(i))
				.toArray()
		).toObject())
	)
	.method('toEnvironment',
		((map) -> truthy.bool.existy(map)),
		((map) ->
			fn = (m, e) ->
				keys = Object.keys(m)

				if keys.length is 0 then e
				else
					key = keys[0]
					value = m[key]

					delete m[key]
					fn(m, e.property(key, value))

			fn(map, bilby.environment())
		)
	)

module.exports = convert

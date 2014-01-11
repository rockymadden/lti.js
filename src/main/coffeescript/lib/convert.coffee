bilby = require('bilby')
lazy = require('lazy.js')
truth = require('./truth')

convert = bilby.environment()
	.method('toMap',
		((environment) -> truth.environmenty(environment)),
		((environment) -> lazy(environment).omit(
			lazy(environment)
				.map((v, k) -> if (truth.existy(v) and typeof v is 'function') then k else null)
				.filter((i) -> truth.existy(i))
				.toArray()
		).toObject())
	)
	.method('toEnvironment',
		((map) -> truth.existy(map)),
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

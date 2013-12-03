bilby = require('bilby')
func = require('./func')
_ = require('underscore')

convert = bilby.environment()
	.method('toMap',
		((environment) -> func.environmenty(environment)),
		((environment) -> _.omit(environment,
			_.chain(environment)
				.map((v, k) -> if (func.existy(v) and typeof v is 'function') then k else null)
				.filter((i) -> func.existy(i))
				.value()
		))
	)
	.method('toEnvironment',
		((map) -> func.existy(map)),
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

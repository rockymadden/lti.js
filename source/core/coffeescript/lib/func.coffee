bilby = require('bilby')
_ = require('underscore')

func = bilby.environment()
	.method('defunc',
		((map) -> func.existy(map)),
		((map) -> _.omit(map,
			_.chain(map)
				.map((v, k) -> if (func.existy(v) and typeof v is 'function') then k else null)
				.filter((i) -> func.existy(i))
				.value()
		))
	)
	.method('environmenty',
		((a) -> true),
		((a) -> @existy(a) and a.hasOwnProperty('method') and a.hasOwnProperty('property'))
	)
	.method('existy',
		((a) -> true),
		((a) -> a?)
	)
	.method('lengthy',
		((a) -> true),
		((a) -> @truthy(a) and a.hasOwnProperty('length') and a.length > 0?)
	)
	.method('signedOAuthy',
		((a) -> true),
		((a) -> @unsignedOAuthy(a) and a.hasOwnProperty('oauth_signature'))
	)
	.method('toolcontexty',
		((a) -> true),
		((a) ->
			@environmenty(a) and
			a.hasOwnProperty('consumerKey') and a.hasOwnProperty('consumerSecret') and
			a.hasOwnProperty('utcOffset') and a.hasOwnProperty('host') and
			a.hasOwnProperty('path') and a.hasOwnProperty('port')
		)
	)
	.method('toolparametery',
		((a) -> true),
		((a) ->
			@environmenty(a) and
			a.hasOwnProperty('lti_message_type') and
			a.hasOwnProperty('lti_version') and
			a.hasOwnProperty('resource_link_id')
		)
	)
	.method('toolquerystringy',
		((a) -> true),
		((a) -> @environmenty(a))
	)
	.method('truthy',
		((a) -> true),
		((a) -> @existy(a) and (a isnt false))
	)
	.method('unsignedOAuthy',
		((a) -> true),
		((a) ->
			@existy(a) and
			a.hasOwnProperty('oauth_callback') and a.hasOwnProperty('oauth_consumer_key') and
			a.hasOwnProperty('oauth_nonce') and a.hasOwnProperty('oauth_timestamp') and
			a.hasOwnProperty('oauth_signature_method') and a.hasOwnProperty('oauth_version')
		)
	)

module.exports = func

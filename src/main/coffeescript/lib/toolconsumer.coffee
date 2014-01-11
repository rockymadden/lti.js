bilby = require('bilby')
convert = require('./convert')
encode = require('./encode')
http = require('http')
oauth = require('./oauth')
q = require('q')
truth = require('./truth')
truthy = require('truthy-js')

toolconsumer = bilby.environment()
	.property('toolcontext', null)
	.method('request',
		((toolparameters, toolquerystring) ->
			truth.toolparametery(toolparameters) and
			(not truthy.bool.existy(toolquerystring) or truth.toolquerystringy(toolparameters))
		),
		((toolparameters, toolquerystring) ->
			deferred = q.defer()

			url = (if @toolcontext.port is 443 then 'https://' else 'http://') + @toolcontext.host + @toolcontext.path
			authorization =
				oauth.property(
					'utcOffset',
					truthy.opt.existy(@toolcontext.utcOffset).getOrElse(0)
				).authorization(
					url,
					bilby.extend(
						toolparameters,
						truthy.opt.existy(toolquerystring).getOrElse({})
					),
					@toolcontext.consumerKey,
					@toolcontext.consumerSecret
				)
			# Many vendors don't seem to honor OAuth 1.0A section 5.2 bullet 1. Toss the parameters in the post data
			# instead of the authorization header.
			content = encode.url(bilby.extend(toolparameters, authorization))
			options =
				headers:
					'Accept': '*/*'
					'Connection': 'close'
					'Content-Type': 'application/x-www-form-urlencoded'
					'Content-Length': content.length
					'Host': @toolcontext.host
					'User-Agent': 'lti.js'
				host: @toolcontext.host
				method: 'POST'
				path: @toolcontext.path +
					if truth.toolquerystringy(toolquerystring) then '?' + encode.url(toolquerystring) else ''
				port: @toolcontext.port
			request = http.request(options, (response) ->
				data = ''

				response.on('data', (chunk) -> data += chunk)
				response.on('end', -> deferred.resolve(bilby.some(data)))
				response.on('error', (error) -> deferred.reject(error))
			)
			request.write(content)
			request.end()

			deferred.promise
		)
	)

friendlytoolconsumer = toolconsumer
	.method('request',
		((toolparameters, toolquerystring) ->
			not truth.toolparametery(toolparameters) and
			(not truthy.bool.existy(toolquerystring) or not truth.toolquerystringy(toolparameters))
		),
		((toolparameters, toolquerystring) ->
			if truthy.bool.existy(toolquerystring)
				bilby.bind(toolconsumer.request)(
					@,
					convert.toEnvironment(toolparameters),
					convert.toEnvironment(toolquerystring)
				)()
			else bilby.bind(toolconsumer.request)(@, convert.toEnvironment(toolparameters))()
		)
	)

module.exports = friendlytoolconsumer

bilby = require('bilby')
encode = require('./encode')
func = require('./func')
http = require('http')
oauth = require('./oauth')
q = require('q')
_ = require('underscore')

# Adheres to LTIv1-12.
toolconsumer = bilby.environment()
	.property('toolcontext', null)
	.method('request',
		((toolparameters, toolquerystring) -> func.toolparametery(toolparameters)),
		((toolparameters, toolquerystring) ->
			deferred = q.defer()

			url = (if @toolcontext.port is 443 then 'https://' else 'http://') + @toolcontext.host + @toolcontext.path
			authorization =
				oauth.property(
					'utcOffset',
					if func.existy(@toolcontext.utcOffset) then @toolcontext.utcOffset else 0
				).authorization(
					url,
					bilby.extend(
						toolparameters,
						(if func.toolquerystringy(toolquerystring) then toolquerystring else {})
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
					if func.toolquerystringy(toolquerystring) then '?' + encode.url(toolquerystring) else ''
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

module.exports = toolconsumer

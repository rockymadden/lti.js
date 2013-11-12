bilby = require('bilby')
http = require('http')
oauth = require('./oauth')
q = require('q')
_ = require('underscore')

# Adheres to LTIv1-12.
toolconsumer = bilby.environment()
	.method('basicRequest',
		((toolcontext, formParameters, urlParameters) ->
			toolcontext? and formParameters? and
			_.has(formParameters, 'lti_message_type') and
			_.has(formParameters, 'lti_version') and
			_.has(formParameters, 'resource_link_id')
		),
		((toolcontext, formParameters, urlParameters) ->
			deferred = q.defer()

			url = (if toolcontext.port is 443 then 'https://' else 'http://') + toolcontext.host + toolcontext.path
			authorization = oauth.authorization(
				url,
				bilby.extend(formParameters, (if urlParameters? then urlParameters else {})),
				toolcontext.consumerKey,
				toolcontext.consumerSecret
			)
			content = _.map(
				bilby.extend(formParameters, authorization),
				(v, k) -> encodeURIComponent(k) + '=' + encodeURIComponent(v.toString())
			).join('&')
			options =
				headers:
					'Accept': '*/*'
					'Authorization': oauth.stringify(authorization)
					'Connection': 'close'
					'Content-Type': 'application/x-www-form-urlencoded'
					'Content-Length': content.length
					'Host': toolcontext.host
					'User-Agent': 'lti.js'
				host: toolcontext.host
				method: 'POST'
				path: toolcontext.path
				port: toolcontext.port
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

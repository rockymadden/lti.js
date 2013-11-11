bilby = require('bilby')
http = require('http')
oauth = require('./oauth')
q = require('q')
_ = require('underscore')

# Adheres to LTIv1-12.
toolconsumer = bilby.environment()
	.property('consumerKey', null)
	.property('consumerSecret', null)
	.property('host', null)
	.property('port', null)
	.method('basicRequest',
		((path, formParameters, urlParameters) ->
			path? and typeof path is 'string' and formParameters? and typeof formParameters is 'object' and
			_.has(formParameters, 'lti_message_type') and _.has(formParameters, 'lti_version') and
			typeof urlParameters is 'object'
		),
		((path, formParameters, urlParameters) ->
			deferred = q.defer()

			url = (if @port is 443 then 'https://' else 'http://') + @host + path
			content = _.map(formParameters, (v, k) ->
				encodeURIComponent(k) + '=' + encodeURIComponent(v.toString())
			).join('&')
			options =
				headers:
					'Accept': '*/*'
					'Authorization': oauth.stringify(
						oauth.authorization(
							url,
							bilby.extend(formParameters, (if urlParameters? then urlParameters else {})),
							@consumerKey,
							@consumerSecret
						)
					)
					'Content-Type': 'application/x-www-form-urlencoded'
					'Content-Length': content.length
					'Host': @host
				host: @host
				method: 'POST'
				path: path
				port: @port
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

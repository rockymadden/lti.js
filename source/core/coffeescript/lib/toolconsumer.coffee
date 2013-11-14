bilby = require('bilby')
encode = require('./encode')
http = require('http')
oauth = require('./oauth')
q = require('q')
_ = require('underscore')

# Adheres to LTIv1-12.
toolconsumer = bilby.environment()
	.method('request',
		((toolcontext, formParameters, urlParameters) ->
			toolcontext? and formParameters? and
			_.has(formParameters, 'lti_message_type') and
			_.has(formParameters, 'lti_version') and
			_.has(formParameters, 'resource_link_id')
		),
		((toolcontext, formParameters, urlParameters) ->
			deferred = q.defer()

			url = (if toolcontext.port is 443 then 'https://' else 'http://') + toolcontext.host + toolcontext.path
			authorization =
				oauth.property(
					'utcOffset',
					if toolcontext.utcOffset? then toolcontext.utcOffset else 0
				).authorization(
					url,
					bilby.extend(formParameters, (if urlParameters? then urlParameters else {})),
					toolcontext.consumerKey,
					toolcontext.consumerSecret
				)
			# Many vendors don't seem to honor OAuth 1.0A section 5.2 bullet 1. Toss the parameters in the post data
			# instead of the authorization header.
			content = encode.httpPostData(bilby.extend(formParameters, authorization))
			options =
				headers:
					'Accept': '*/*'
					'Connection': 'close'
					'Content-Type': 'application/x-www-form-urlencoded'
					'Content-Length': content.length
					'Host': toolcontext.host
					'User-Agent': 'lti.js'
				host: toolcontext.host
				method: 'POST'
				path: toolcontext.path + if urlParameters? then '?' + encode.httpPostData(urlParameters) else ''
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

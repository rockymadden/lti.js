bilby = require('bilby')
encode = require('./encode')
lazy = require('lazy.js')
oauth = require('./oauth')
q = require('q')
truthy = require('truthy.js')

toolconsumer =
	http:
		post: (context, parameters, querystring) ->
			deferred = q.defer()

			authorization = oauth.authorization(
				(if context.port is 443 then 'https://' else 'http://') + context.host + context.path,
				lazy(parameters).extend(truthy.opt.existy(querystring).getOrElse({})).toObject(),
				context.key,
				context.secret,
				context.utcOffset
			).getOrElse({})
			content = encode.url(lazy(parameters).extend(authorization).toObject()).getOrElse('')
			options =
				headers:
					'Accept': '*/*'
					'Connection': 'close'
					'Content-Type': 'application/x-www-form-urlencoded'
					'Content-Length': content.length
					'Host': context.host
					'User-Agent': 'lti.js'
				host: context.host
				method: 'POST'
				path: context.path + truthy.opt.lengthy(querystring).map((_) -> '?' + encode.url(_)).getOrElse('')
				port: context.port
			request = (if context.port is 443 then require('https') else require('http')).request(options, (response) ->
				data = ''
				response.on('data', (chunk) -> data += chunk)
				response.on('end', -> deferred.resolve(bilby.some(data)))
				response.on('error', (error) -> deferred.reject(error))
			)
			request.write(content)
			request.end()

			deferred.promise

	ToolConsumer: class ToolConsumer
		constructor: (host, path, port, key, secret, utcOffset = 0) ->
			@host = host
			@path = path
			@port = port
			@key = key
			@secret = secret
			@utcOffset = utcOffset

		withSession: (f) ->
			f(Object.freeze(
				post: bilby.bind(toolconsumer.http.post)(
					toolconsumer.http,
					Object.freeze(
						host: @host
						path: @path
						port: @port
						key: @key
						secret: @secret
						utcOffset: @utcOffset
					)
				)
			))

module.exports = Object.freeze(toolconsumer)

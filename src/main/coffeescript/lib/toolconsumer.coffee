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
				((if context.port is 443 then 'https://' else 'http://') + context.host + context.path),
				lazy(parameters).extend(truthy.opt.existy(querystring).getOrElse({})).toObject(),
				context.oauthConsumerKey,
				context.oauthConsumerSecret,
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
				path: context.path + truthy.opt.lengthy(querystring).map((qs) -> '?' + encode.url(qs)).getOrElse('')
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
		constructor: (host, path, port, oauthConsumerKey, oauthConsumerSecret, utcOffset = 0) ->
			@host = host
			@path = path
			@port = port
			@oauthConsumerKey = oauthConsumerKey
			@oauthConsumerSecret = oauthConsumerSecret
			@utcOffset = utcOffset

		withSession: (f) ->
			context = Object.freeze(
				host: @host
				path: @path
				port: @port
				oauthConsumerKey: @oauthConsumerKey
				oauthConsumerSecret: @oauthConsumerSecret
				utcOffset: @utcOffset
			)
			http = Object.freeze(
				post: bilby.bind(toolconsumer.http.post)(toolconsumer.http, context)
			)

			f(http)

module.exports = Object.freeze(toolconsumer)

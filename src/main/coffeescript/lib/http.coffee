Agent = require('keep-alive-agent')
bilby = require('bilby')
encode = require('./encode')
oauth = require('./oauth')
q = require('q')
qio = require('q-io/http')
truthy = require('truthy.js')

http = class Http
	@parse: (response) -> truthy.opt.lengthy(response)

	@querystring: (parameters) -> truthy.opt.lengthy(parameters).map((_) -> '?' + encode.url(_)).getOrElse('')

	constructor: (@baseUrl, @consumerKey, @consumerSecret) ->
		@agent = if @baseUrl.indexOf('https:') == 0 then new Agent.Secure() else new Agent()

	post: (payload, parameters) -> @withBody('POST')(payload, parameters)

	withBody: (verb) => (payload, parameters) =>
		deferred = q.defer()
		oauthUrl = @baseUrl
		requestUrl = oauthUrl + http.querystring(parameters)

		oauth.authorization(verb, oauthUrl, bilby.extend(payload, parameters), @consumerKey, @consumerSecret).cata(
			success: (auth) ->
				body = encode.url(bilby.extend(payload, auth))
				request =
					agent: @agent
					headers:
						'Content-Length': Buffer.byteLength(body, 'utf8')
						'Content-Type': 'application/x-www-form-urlencoded'
						'User-Agent': 'lti.js'
					method: verb
					url: requestUrl
					body: [body]

				qio.request(request)
					.then((_) -> _.body.read())
					.then((_) -> deferred.resolve(Http.parse(_.toString())))
					.catch((_) -> deferred.reject(_))
					.done()

			failure: (_) -> deferred.reject(_)
		)

		deferred.promise

module.exports = Object.freeze(http)

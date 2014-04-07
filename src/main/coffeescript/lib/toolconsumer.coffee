bilby = require('bilby')
Http = require('./http')

toolconsumer = class ToolConsumer
	constructor: (@baseUrl, @consumerKey, @consumerSecret) ->

	withSession: (f) ->
		http = new Http(@baseUrl, @consumerKey, @consumerSecret)

		f(Object.freeze(
			basicLaunch: bilby.bind(http.post)(http)
		))

module.exports = Object.freeze(toolconsumer)

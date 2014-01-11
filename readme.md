#lti.js [![Build Status](http://img.shields.io/travis-ci/rockymadden/lti.js.png)](http://travis-ci.org/rockymadden/lti.js) [![Generic](http://img.shields.io/coverage/99%25.png?color=green)]()
Functional library for interacting, via server-to-server communications, with Learning Tools Interoperability (LTI) tool providers. The project makes heavy use of [bilby.js](https://github.com/puffnfresh/bilby.js) and [Q](https://github.com/kriskowal/q). You will likely need a familiarity with basic functional programming concepts and promises to be successful.

## Depending Upon
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/lti). Add the dependency in your package.json file:

```javascript
"dependencies": {
	"lti": "0.3.x"
}
```

## Concepts
* __Tool Contexts:__ Tool contexts are immutable structures made up of the consumer key, consumer/shared secret, host, path, port (default: 443), and UTC offset (default: 0). It is unusual for contexts to change per request, but it is possible depending upon the tool provider. If new contexts are needed, create a base context. This will provide lens-like behavior in which new contexts only need to specify what is different. See [bilby.js](http://bilby.brianmckenna.org/#environment) for more information.
* __Tool Consumers:__ Tool consumers allow you to issue one or more asynchronous requests to tool providers and handle the response(s). Responses return Q based promises. Each contains an option monad. See [Q](https://github.com/kriskowal/q) and [bilby.js](http://bilby.brianmckenna.org/#option) for more information.

## Usage (CoffeeScript)

Setup tool context:
```coffeescript
context = lti.ToolContext
	.property('consumerKey', 'consumerKey')
	.property('consumerSecret', 'consumerSecret')
	.property('host', 'example.com')
	.property('path', '/lti')
```

Create session and leverage tool consumer:
```coffeescript
context.withSession((consumer) ->
	parameters =
		lti_version: 'LTI-1p0'
		lti_message_type: 'basic-lti-launch-request'
		resource_link_id: '0'

	# Simple one-off request. We could also make a large array of promises and asynchronously
	# execute all of them. Check out: https://github.com/kriskowal/q/wiki/API-Reference#promiseall
	consumer.request(parameters)
		.then((response) -> response.map((r) -> console.dir(r)))
		.catch((error) -> console.log(error))
		.done(-> console.log('All done!'))
)
```

## License
```
The MIT License (MIT)

Copyright (c) 2013 Rocky Madden (http://rockymadden.com/)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

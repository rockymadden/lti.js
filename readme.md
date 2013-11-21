#lti.js [![Build Status](https://travis-ci.org/rockymadden/lti.js.png?branch=master)](http://travis-ci.org/rockymadden/lti.js)
Functional library for interacting, via server-to-server communications, with Learning Tools Interoperability (LTI) tool providers.

## Depending
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/lti). Add the dependency in your package.json file:

```javascript
"dependencies": {
	"lti": "0.2.x"
}
```

## Building
```shell
npm install
grunt
```

## Using
Example in which tool contexts do not change in-between calls (the most common scenario):
```coffeescript
context = toolcontext
	.property('consumerKey', 'consumerKey')
	.property('consumerSecret', 'consumerSecret')
	.property('host', 'example.com')
	.property('path', '/lti')
consumer = toolconsumer
	.property('toolcontext', context)

# Request number one.
consumer.request(toolparameters.property('resource_link_id', '1234567890')).then((response) ->
	response.map((r) -> console.dir(r))
)

# Request number two.
consumer.request(toolparameters.property('resource_link_id', '0123456789')).then((response) ->
	response.map((r) -> console.dir(r))
)
```
More usage examples available via the [project unit tests](https://github.com/rockymadden/lti.js/tree/master/source/test/coffeescript/lib).

## Conceptualizing
* __Tool Contexts:__ Tool contexts are immutable structures made up of the consumer key, consumer/shared secret, host, path, port (default: 443), and UTC offset (default: 0). It is unusual for contexts to change per request, but it is possible depending upon the tool provider. If new contexts are needed, create a base context. This will provide lens-like behavior in which new contexts only need to specify what is different. See [bilby.js](http://bilby.brianmckenna.org/#environment) for more information.
* __Tool Parameters:__ Tool parameters are immutable structures made up of, at minimum, lti\_message\_type (default: basic-lti-launch-request), lti\_version (default: LTI-1p0), and resource\_link\_id. It is very likely for parameters to change per request. If numerous parameters are needed, create a stable base. This will provide lens-like behavior in which new parameters only need to specify what is different. See [bilby.js](http://bilby.brianmckenna.org/#environment) for more information.
* __Tool Consumers:__ Tool consumers allow you to issue one or more asynchronous requests and handle the response(s). Responses return Q based promises. Each contains an option monad. See [Q](https://github.com/kriskowal/q) and [bilby.js](http://bilby.brianmckenna.org/#option) for more information.

## Licensing
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
#lti.js [![Build Status](https://travis-ci.org/rockymadden/lti.js.png?branch=master)](http://travis-ci.org/rockymadden/lti.js)
Functional library for interacting, via server-to-server communications, with Learning Tools Interoperability (LTI) tool providers.

## Depending
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/lti). Add the dependency in your package.json file:

```javascript
"dependencies": {
	"lti": "0.1.x"
}
```

## Building
```shell
npm install
grunt
```

## Using
```coffeescript
# Tool contexts are immutable structures made up of the consumer key,
# consumer secret, host, path, port, and optionally a UTC offset. It is
# unusual for contexts to change per request, but it is possible depending
# upon the tool provider. If new contexts are needed, create a core context.
# This will provide lens-like behavior in which new contexts only need to
# change what is different. See http://bilby.brianmckenna.org/#environment
# for more information.
context = toolcontext
	.property('consumerKey', 'consumerKey')
	.property('consumerSecret', 'consumerSecret')
	.property('host', 'example.com')
	.property('path', '/lti')
	.property('port', 443)

# Post data parameters, these do typically change per request. At minimum,
# the three key value pairs below are required for LTI requests.
formParams =
	lti_message_type: 'basic-lti-launch-request'
	lti_version: 'LTI-1p0'
	resource_link_id: '1234567890'
	
# URL parameters, if any. This is an optional argument for requests.
urlParams = null

# Issue one or more requests and handle the response(s). Responses returned
# are asynchronous promises. Each contains an option monad. See
# https://github.com/kriskowal/q and http://bilby.brianmckenna.org/#option
# for more information.
toolconsumer.request(context, formParams).then((response) ->
	response.map((r) -> console.dir(r))
)
```
More usage examples available via the [project unit tests](https://github.com/rockymadden/lti.js/tree/master/source/test/coffeescript/lib).

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
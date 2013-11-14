#lti.js [![Build Status](https://travis-ci.org/rockymadden/lti.js.png?branch=master)](http://travis-ci.org/rockymadden/lti.js)
Functional library for interacting, via server-to-server communications, with Learning Tools Interoperability (LTI) tool providers.

## Depending
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/lti). Add the dependency in your package.json file:

```javascript
"dependencies": {
	"lti": "0.0.x"
}
```

## Building
```shell
npm install
grunt
```

## Using
```coffeescript
# Create tool context. This may change per request, depending upon your
# usage (e.g. if a different URL is needed each request). This is not
# common, as most parameters are specified in the post data itself. If
# new contexts are needed, create a new immutable context based off of
# a core context. This will provide lens-like behavior in which you
# only need to change what is different between the two (e.g. path).
context = toolcontext
	.property('consumerKey', 'consumerKey')
	.property('consumerSecret', 'consumerSecret')
	.property('host', 'example.com')
	.property('path', '/lti')
	.property('port', 443)

# Create your post data parameters. 
params =
	lti_message_type: 'basic-lti-launch-request'
	lti_version: 'LTI-1p0'
	resource_link_id: '1234567890'

# Issue one or more requests and handle the response(s). The response
# returned is a promise containing an option monad.
toolconsumer.request(context, params).then((response) ->
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
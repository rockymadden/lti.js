#lti.js [![Build Status](http://img.shields.io/travis-ci/rockymadden/lti.js.png)](http://travis-ci.org/rockymadden/lti.js) [![Generic](http://img.shields.io/coverage/99%25.png?color=green)]()
Learning Tools Interoperability node.js library:

| Functionality | v1.1      | v1.1.1     | v2.0                         |
|---------------| --------- | ---------- | ---------------------------- |
| Tool Consumer | Supported | Supported  | Awaiting Final Specification |
| Tool Provider | Queued    | Queued     | Awaiting Final Specification |

## Depending Upon
The project is available on the [Node Packaged Modules registry](https://npmjs.org/package/lti). Add the dependency in your package.json file:

```javascript
"dependencies": {
	"lti": "0.4.x"
}
```

---

## Usage (CoffeeScript)

Create tool consumer:
```coffeescript
consumer = new lti.ToolConsumer('example.com', '/path', 443, 'key', 'secret')
```

---

Leverage tool consumer:
```coffeescript
consumer.withSession((session) ->
	parameters =
		lti_version: 'LTI-1p0'
		lti_message_type: 'basic-lti-launch-request'
		resource_link_id: '0'

	session.post(parameters)
		.then((response) -> response.map((r) -> console.dir(r)))
		.catch((error) -> console.log(error))
		.done(-> console.log('All done!'))
)
```

---

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

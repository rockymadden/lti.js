should = require('should')
toolparameters = require('./toolparameters')
_ = require('underscore')

describe('toolparameters', ->
	describe('lti_message_type', ->
		it('should exist', -> _.has(toolparameters, 'lti_message_type').should.be.true)
		it('should default to basic-lti-launch-request', ->
			toolparameters.lti_message_type.should.equal('basic-lti-launch-request')
		)
	)
	describe('lti_version', ->
		it('should exist', -> _.has(toolparameters, 'lti_version').should.be.true)
		it('should default to LTI-1p0', -> toolparameters.lti_version.should.equal('LTI-1p0'))
	)
	describe('resource_link_id', -> it('should exist', -> _.has(toolparameters, 'resource_link_id').should.be.true))
)

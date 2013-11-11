module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			core: files: [
				'build/lib/oauth.js': 'source/core/coffeescript/lib/oauth.coffee'
				'build/lib/toolconsumer.js': 'source/core/coffeescript/lib/toolconsumer.coffee'
				'build/lib/toolcontext.js': 'source/core/coffeescript/lib/toolcontext.coffee'
			]
			test: files: [
				'build/lib/oauth-test.js': 'source/test/coffeescript/lib/oauth-test.coffee'
				'build/lib/toolconsumer-test.js': 'source/test/coffeescript/lib/toolconsumer-test.coffee'
			]
		copy:
			test: files: ['build/etc/toolconsumer.config.json': 'resource/test/json/etc/toolconsumer.config.json']
		cafemocha: all:
			src: 'build/**/*-test.js'
			options: timeout: 512000

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('default', ['coffee', 'copy'])
	grunt.registerTask('test', ['default', 'cafemocha'])


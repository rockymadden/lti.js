module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			core: files: ['build/lib/oauth.js': 'source/core/coffeescript/lib/oauth.coffee']
			test: files: ['build/lib/oauth-test.js': 'source/test/coffeescript/lib/oauth-test.coffee']
		cafemocha: all:
			src: 'build/**/*-test.js'
			options: timeout: 512000

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('default', ['coffee'])
	grunt.registerTask('test', ['default', 'cafemocha'])


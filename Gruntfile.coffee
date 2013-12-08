module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			core: files: [{
				expand: true
				cwd: 'source/core/coffeescript/'
				src: ['**/*.coffee']
				dest: 'build/'
				ext: '.js'
			}]
			test: files: [{
				expand: true
				cwd: 'source/test/coffeescript/'
				src: ['**/*.coffee']
				dest: 'build/'
				ext: '.js'
			}]
		mochacov:
			options:
				files: ['build/**/*-test.js']
				require: ['should']
				slow: 500
				timeout: 16000
			test: options: reporter: 'spec'
			coverage: options: coveralls: serviceName: 'travis-ci'

	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-mocha-cov')

	grunt.registerTask('default', ['coffee'])
	grunt.registerTask('test', ['default', 'mochacov:test'])
	grunt.registerTask('travis', ['test', 'mochacov:coverage'])

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
		copy: test: files: ['build/etc/toolconsumer-test.config.json': 'resource/test/json/etc/toolconsumer-test.config.json']
		cafemocha:
			options: timeout: 16000
			all: src: ['build/**/*-test.js']
			travis: src: ['build/**/*-test.js']
		mochacov:
			options:
				reporter: 'spec'
				require: ['should']
				quiet: true
			all: src: ['build/**/*-test.js']
			travis:
				src: ['build/**/*-test.js']
				options: coveralls: serviceName: 'travis-ci'

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')
	grunt.loadNpmTasks('grunt-mocha-cov')

	grunt.registerTask('default', ['coffee', 'copy'])
	grunt.registerTask('test', ['default', 'cafemocha:all', 'mochacov:all'])
	grunt.registerTask('travis', ['default', 'cafemocha:travis', 'mochacov:travis'])

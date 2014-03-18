module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			main: files: [{
				expand: true
				cwd: 'src/main/coffeescript/'
				src: ['**/*.coffee']
				dest: 'target/'
				ext: '.js'
			}]
			test: files: [{
				expand: true
				cwd: 'src/test/coffeescript/'
				src: ['**/*.coffee']
				dest: 'target/'
				ext: '.js'
			}]
		mochacov:
			coverage: options:
				reporter: 'mocha-term-cov-reporter'
				coverage: true
			options:
				files: ['target/**/*-test.js']
				require: ['should']
				slow: 500
				timeout: 16000
			test: options: reporter: 'spec'

	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-mocha-cov')

	grunt.registerTask('coverage', ['default', 'coffee:test', 'mochacov:coverage'])
	grunt.registerTask('default', ['coffee:main'])
	grunt.registerTask('test', ['default', 'coffee:test', 'mochacov:test'])

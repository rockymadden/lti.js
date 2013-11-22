module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			core: files: [
				expand: true
				cwd: 'source/core/coffeescript/'
				src: ['**/*.coffee']
				dest: 'build/'
				ext: '.js'
			]
			test: files: [
				expand: true
				cwd: 'source/test/coffeescript/'
				src: ['**/*.coffee']
				dest: 'build/'
				ext: '.js'
			]
		copy: test: files: ['build/toolconsumer-test.config.json': 'resource/test/json/toolconsumer-test.config.json']
		cafemocha:
			all: src: ['build/**/*-test.js']
			travis: src: [
				'build/encode-test.js'
				'build/oauth-test.js'
				'build/toolcontext-test.js'
				'build/toolparameters-test.js'
				'build/toolquerystring-test.js'
			]

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('default', ['coffee', 'copy'])
	grunt.registerTask('test', ['default', 'cafemocha:all'])
	grunt.registerTask('travis', ['default', 'cafemocha:travis'])


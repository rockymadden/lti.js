module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		coffee:
			core: files: [
				{
					expand: true
					cwd: 'source/core/coffeescript/lib/'
					src: ['**/*.coffee']
					dest: 'build/lib/'
					ext: '.js'
				}, {
					expand: true
					cwd: 'source/core/coffeescript/'
					src: ['**/*.coffee']
					dest: 'build/'
					ext: '.js'
				}
			]
			test: files: [
				{
					expand: true
					cwd: 'source/test/coffeescript/lib/'
					src: ['**/*.coffee']
					dest: 'build/lib/'
					ext: '.js'
				}, {
					expand: true
					cwd: 'source/test/coffeescript/'
					src: ['**/*.coffee']
					dest: 'build/'
					ext: '.js'
				}
			]
		copy: test: files: ['build/etc/toolconsumer-test.config.json': 'resource/test/json/etc/toolconsumer-test.config.json']
		cafemocha:
			all: src: ['build/**/*-test.js']
			travis: src: [
				'build/lib/encode-test.js'
				'build/lib/oauth-test.js'
				'build/lib/toolcontext-test.js'
				'build/lib/toolparameters-test.js'
				'build/lib/toolquerystring-test.js'
			]

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('default', ['coffee', 'copy'])
	grunt.registerTask('test', ['default', 'cafemocha:all'])
	grunt.registerTask('travis', ['default', 'cafemocha:travis'])


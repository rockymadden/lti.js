module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		cafemocha: all:
			src: 'build/**/*-test.js'
			options: timeout: 512000

	grunt.loadNpmTasks('grunt-cafe-mocha')
	grunt.loadNpmTasks('grunt-contrib-coffee')
	grunt.loadNpmTasks('grunt-contrib-copy')

	grunt.registerTask('default', ['coffee', 'copy'])
	grunt.registerTask('test', ['default', 'cafemocha'])


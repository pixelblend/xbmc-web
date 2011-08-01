{spawn, exec} = require 'child_process'
sys = require 'sys'

runCommand = (name, args...) ->
  proc =           spawn name, args
  proc.stderr.on   'data', (buffer) -> console.log buffer.toString()
  proc.stdout.on   'data', (buffer) -> console.log buffer.toString()
  proc.on          'exit', (status) -> process.exit(1) if status isnt 0


task 'assets:watch', 'Watch source files and build JS & CSS', (options) ->
  #runCommand 'sass',   ['--watch', 'public/css/sass:public/css']
  runCommand 'coffee', '-o', 'public/scripts', '-wc', 'lib'
  runCommand 'coffee', '-o', 'spec/javascripts', '-wc', 'spec/lib'

task 'assets', 'Compile source files', (options) ->
  #runCommand 'sass',   ['--watch', 'public/css/sass:public/css']
  runCommand 'coffee', '-o', 'public/scripts', '-c', 'lib'
  runCommand 'coffee', '-o', 'spec/javascripts', '-c', 'spec/lib'

# Alternately, compile CoffeeScript programmatically
# CoffeeScript = require "coffee-script"
# CoffeeScript.compile fs.readFileSync filename

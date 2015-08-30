#!/usr/bin/env ruby

# =============================
#    Customize these params!
# =============================

# The directory where the game server is
working_dir = '/home/edoardo/Scrivania/openarena-0.8.8'
# The command to execute in that directory
command = './oa_ded.x86_64'
# An array of params to pass to the server
params = []
# The user who runs the server.
# NOTICE: the current user must be able to sudo to the user
# TIP: add the following line in the sudoers file
#   current_usre ALL=(user) NOPASSWD: ALL
user = 'edoardo'
# Screen name to assign to this game. It really should be unique
screen_name = 'XXX'


# ============================
#    Don't touch from here!
# ============================
require 'json'

result = {}

begin
	real_command = [
		'screen',											# open a new screen
		'-d', '-m',											# detached mode
		'-L',												# enable logging
		'-S', screen_name,									# assign the name to the scren
		'sudo',	'-u', user,									# run the command as user
		"bash -c '#{command} " + params.join(' ') + "'"		# execute command
	].join(' ')

	screen_pid = 'unknown'

	Dir.chdir(working_dir) do
		process = IO.popen(real_command)
		screen_pid = process.pid
	end
	
	result[:status] = 'Success'
	result[:info] = "Screen pid is #{screen_pid}"
rescue
	result[:status] = 'Error'
end

puts JSON.generate result

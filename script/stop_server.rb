#!/usr/bin/env ruby

# =============================
#    Customize these params!
# =============================

# The user who runs the server.
# NOTICE: the current user must be able to sudo to the user
# TIP: add the following line in the sudoers file
#   current_usre ALL=(user) NOPASSWD: ALL
user = 'edoardo'
# Screen name assigned to this game
screen_name = 'XXX'

# ============================
#    Don't touch from here!
# ============================
require 'json'

result = {}

begin
	screen_pids = IO.popen("screen -ls | grep #{screen_name} | cut -d. -f1").readlines

	if screen_pids.length == 0
		result[:error] = 'The game instance was not found'
		result[:status] = 'Failed'
	else
		if screen_pids.length > 1
			result[:warning] = 'Found more than one instance of the game... Not so good...'
		end
		
		screen_pid = screen_pids[0].strip
		game_bash_pid = IO.popen("ps h --ppid #{screen_pid} -o pid").readline.strip
		game_pid = IO.popen("ps h --ppid #{game_bash_pid} -o pid").readline.strip
		
		IO.popen("sudo -u #{user} kill -INT #{game_pid}")
		result[:info] = "SIGINT sent to #{game_pid}"
		result[:status] = 'Success'
	end
rescue
	result[:status] = 'Failed'
end

puts JSON.generate result

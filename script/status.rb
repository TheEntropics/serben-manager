#!/usr/bin/env ruby

# =============================
#    Customize these params!
# =============================

# Screen name assigned to this game
screen_name = 'XXX'
log_file = '/tmp/timur.log'
log_lines = 100

# ============================
#    Don't touch from here!
# ============================
require 'json'

result = {}

begin
	screen_pids = IO.popen("screen -ls | grep #{screen_name} | cut -d. -f1").readlines

	if screen_pids.length == 0
		result[:online] = false
	else
		if screen_pids.length > 1
			result[:warning] = 'Found more than one instance of the game... Not so good...'
			result[:instances] = screen_pids.length
		end

    log = IO.popen("cat '#{log_file}' | tail -n #{log_lines}").readlines
    result[:log] = log
    result[:log_lines] = log_lines

		result[:online] = true
	end
rescue
	result[:online] = 'Error'
end

puts JSON.generate result

#!/usr/bin/env ruby

# =============================
#    Customize these params!
# =============================

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
		result[:online] = false
	else
		if screen_pids.length > 1
			result[:warning] = 'Found more than one instance of the game... Not so good...'
			result[:instances] = screen_pids.length
		end
		
		result[:online] = true
	end
rescue
	result[:online] = 'Error'
end

puts JSON.generate result

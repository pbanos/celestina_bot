require "celestina_bot/version"
require "celestina_bot/config"
require "celestina_bot/logger"
require "celestina_bot/twitter"
require 'celestina_bot/match'
require 'celestina_bot/schedule'

module CelestinaBot
	def self.work
		match_maker = CelestinaBot::Match::Maker.new
		loop do
			CelestinaBot::Logger.debug "Matchmaking starts..."
			next_time = CelestinaBot::Schedule.next_time
			begin
				match = match_maker.make_match
				if match
					match_maker.introduce(match)
				else
					CelestinaBot::Logger.debug "Match could not be made, will try later"
				end
			rescue Grackle::TwitterError => e
				CelestinaBot::Logger.error e.message
			end
			if (seconds_to_sleep = next_time - Time.now) > 0
				CelestinaBot::Logger.debug "Back to sleep until #{next_time}"
				sleep(seconds_to_sleep)
			end
		end
	end
end

require "celestina_bot/version"
require "celestina_bot/config"
require "celestina_bot/logger"
require "celestina_bot/twitter"
require 'celestina_bot/match'

module CelestinaBot
	def self.work
		match_maker = CelestinaBot::Match::Maker.new
		loop do
			CelestinaBot::Logger.debug "Matchmaking starts..."
			begin
				match = match_maker.make_match
				#if match
				#	CelestinaBot::Logger.info "Match made: #{[match.calixto, match.melibea].collect(&:screen_name).inspect}"
				#end
			rescue Grackle::TwitterError => e
				CelestinaBot::Logger.error e.message
			end
			CelestinaBot::Logger.debug "Back to sleep for 60 seconds"
			sleep 60
		end
	end
end

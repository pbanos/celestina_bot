require "celestina_bot/version"
require "celestina_bot/config"
require "celestina_bot/twitter"
require 'celestina_bot/match'

module CelestinaBot
	def self.work
		match_maker = CelestinaBot::Match::Maker.new
		loop do
			puts "Making a match..."
			begin
				match = match_maker.make_match
				puts "Match done: #{[match.calixto, match.melibea].collect(&:screen_name).inspect}"
			rescue Grackle::TwitterError => e
				$stderr.puts e.message
			end
			puts "Back to sleep"
			sleep 60
		end
	end
end

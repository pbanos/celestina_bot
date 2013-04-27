require 'celestina_bot/twitter'

class CelestinaBot::Match::Maker

	MATCH_INTRODUCTIONS = if (configured_introductions = CelestinaBot::Config['match_introductions']) and configured_introductions.is_a?(Array)
		configured_introductions.collect(&:freeze)
	else
		CelestinaBot::Logger.fatal "Could not load match introductions from configuration"
		$stderr.puts "Could not load match introductions from configuration"
		exit(4)
	end

	attr_reader :strategy, :client

	def initialize(strategy=nil)
		@client = CelestinaBot::Twitter.new
		@strategy = strategy || RandomMatching.new
	end

	def make_match
		CelestinaBot::Logger.debug("Making a match with the #{strategy.class.name} strategy")
		strategy.make_match(@client)
	end

	def introduce(match)
		CelestinaBot::Logger.info('Introducing the match #{match}')
		introduction = MATCH_INTRODUCTIONS.sample.
			gsub('%{calixto}', "@#{match.calixto.screen_name}").
				gsub('%{melibea}', "@#{match.melibea.screen_name}")
		@client.post 'statuses/update', :status => introduction
	end
end

require 'celestina_bot/match/maker/random_matching'
require 'celestina_bot/twitter'

class CelestinaBot::Match::Maker

	attr_reader :strategy, :client

	def initialize(strategy=nil)
		@client = CelestinaBot::Twitter.new
		@strategy = strategy || RandomMatching.new
	end

	def make_match
		strategy.make_match(@client)
	end
end

require 'celestina_bot/match/maker/random_matching'
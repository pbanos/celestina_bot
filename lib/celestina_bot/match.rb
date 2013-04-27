
class CelestinaBot::Match

	attr_reader :calixto, :melibea

	def initialize(calixto, melibea)
		@calixto = calixto
		@melibea = melibea
	end

	def to_s
		[calixto, melibea].collect(&:screen_name).to_s
	end

end

require 'celestina_bot/match/maker'

class CelestinaBot::Match

	attr_reader :calixto, :melibea

	def initialize(calixto, melibea)
		@calixto = calixto
		@melibea = melibea
	end

end

require 'celestina_bot/match/maker'
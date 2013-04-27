require 'celestina_bot/config'
require 'yell'

module CelestinaBot
	unless CelestinaBot::Config['log'] and CelestinaBot::Config['log']['file']
		$stderr.puts "Cannot find log configuration in config file"
		exit(5)
	end

	log_level = (CelestinaBot::Config['log']['level'] || 'info').downcase

	Logger = case CelestinaBot::Config['log']['file']
	when /stdout|stderr/i
		Yell.new(eval(CelestinaBot::Config['log']['file'].upcase), :level => log_level)
	else
		Yell.new(:datefile, CelestinaBot::Config['log']['file'], :date_pattern => "%Y-%m", :level => log_level)
	end
end
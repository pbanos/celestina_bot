require 'yaml'

module CelestinaBot::Config
	@@configuration = begin
		ENV['CELESTINA_BOT_CONFIG_FILE'] ||= File.expand_path('config.yml')
		YAML.load(File.read(ENV['CELESTINA_BOT_CONFIG_FILE']))
	rescue Exception => e
		$stderr.puts "Could not load config from #{ENV['CELESTINA_BOT_CONFIG_FILE']}: #{e.message}"
		exit(1)
	end || {}

	def self.[](key)
		@@configuration[key]
	end
end
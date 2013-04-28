module CelestinaBot::Schedule

	unless CelestinaBot::Config['schedule']
		CelestinaBot::Logger.fatal 'Could not read schedule configuration in config file'
		$stderr.puts 'Could not read schedule configuration in config file'
		exit(6)
	end

	class << self
		attr_accessor :from, :to, :every
	end

	self.from, self.to = %w(from to).collect do |time|
		if (value = CelestinaBot::Config['schedule'][time]) and /\A\d{1,2}:\d\d\Z/.match(value)
			value
		else
			error_msg = "Could not read a valid schedule configuration parameter '#{time}' in config file"
			CelestinaBot::Logger.fatal error_msg
			$stderr.puts error_msg
			exit(7)
		end
	end

	self.every = if (value = CelestinaBot::Config['schedule']['every']) and value.to_i != 0
		value.to_i
	else
		error_msg = "Could not read a valid schedule configuration parameter 'every' in config file"
		CelestinaBot::Logger.fatal error_msg
		$stderr.puts error_msg
		exit(7)
	end

	def self.next_time(current_time = nil)
		current_time ||= Time.now
		next_time = current_time + (every*60)
		if next_time > current_end_time(current_time)
			next_start_time(current_time)
		else
			next_time
		end
	end

	def self.current_end_time(current_time = nil)
		current_time ||= Time.now
		Time.new(current_time.year, current_time.month, current_time.day, * to.split(':').collect(&:to_i))
	end

	def self.next_start_time(current_time = nil)
		current_time ||= Time.now
		tomorrow = Time.new(current_time.year, current_time.month, current_time.day) + 25*3600
		Time.new(tomorrow.year, tomorrow.month, tomorrow.day, * from.split(':').collect(&:to_i))
	end

end
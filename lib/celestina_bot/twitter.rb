require 'grackle'

class CelestinaBot::Twitter
	CREDENTIALS = %w(consumer_key consumer_secret token token_secret).freeze
	
	twitter_config = CelestinaBot::Config['twitter']
	unless twitter_config.is_a?(Hash)
		$stderr.puts("Cannot read twitter configuration")
		exit(2)
	end
	@@twitter_auth = Hash[CREDENTIALS.collect do |credential|
		unless twitter_config[credential]
			$stderr.puts("Cannot read twitter #{credential} configuration")
			exit(3)
		end
		[credential.to_sym, twitter_config[credential]]
	end].merge(:type=>:oauth)

	API_MAX_ATTEMPTS = (twitter_config['max_attempts'] || 3).to_i

	def initialize
		@twitter_client = Grackle::Client.new(:auth=> @@twitter_auth)
	end

	def request(method, resource, parameters={})
		resource = resource.is_a?(Array) ? resource : resource.split(/\.|\//)
		num_attempts = 0
		begin
			num_attempts += 1
			@twitter_client.send(method) do
				resource[0..-2].inject(self) do |req, node|
					req.send(node)
				end.send(resource.last, parameters)
			end
		rescue Grackle::TwitterError => error
			if num_attempts <= API_MAX_ATTEMPTS
				puts error.message
				rate_limit_reset = if @twitter_client.response.headers["X-Rate-Limit-Remaining"] == '0'
					@twitter_client.response.headers["X-Rate-Limit-Reset"]
				end
				rate_limit_reset and (wake_up_time = Time.at(rate_limit_reset.to_i))
				if rate_limit_reset and wake_up_time > Time.now
					puts "Retrying at #{wake_up_time}"
					sleep (wake_up_time - Time.now).ceil
					retry
				else
					raise
				end
			else
				raise
			end
		end
	end

	[:get, :post].each do |method|
		define_method method do |resource, parameters={}|
			request(method, resource, parameters)
		end
	end
	
end
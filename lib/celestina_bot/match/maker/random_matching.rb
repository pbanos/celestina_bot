
class CelestinaBot::Match::Maker::RandomMatching

	def make_match(twitter_client)
		follower_ids = twitter_client.get('followers/ids').ids
		if follower_ids.count > 2
			user_ids = follower_ids.sample(2).join(',')
			CelestinaBot::Match.new(* twitter_client.get('users/lookup', :user_id => user_ids))
		else
			raise "Do not have enough followers yet"
		end
	end
end
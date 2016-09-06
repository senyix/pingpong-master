class Game < ActiveRecord::Base
	has_many :user_played_games
	has_many :users, through: :user_played_games

	attr_accessor :my_score, :opponent_score, :opponent_id
	after_create :update_ranking

	validates :date_played, presence: true
	validates :my_score, presence: true
	validates :opponent_score, presence: true
	validates :opponent_id, presence: true

	def oponnent_name
		oponnent = User.where(id: opponent_id)
		oponnent.map(&:email).first
	end

	def result_of current_user
		if current_user.id == user_played_games[0].user.id
			return user_played_games[1].score.to_i > user_played_games[0].score.to_i ? "L" : "W"
		else
			return user_played_games[1].score.to_i > user_played_games[0].score.to_i ? "w" : "L"
		end
	end

	def opponent_of current_user
		if current_user.id == user_played_games[0].user.id
			return user_played_games[1].user.email
		else
			return user_played_games[0].user.email
		end
	end

	def opponent_score_of current_user
		if current_user.id == user_played_games[0].user.id
			return user_played_games[0].score + "-" + user_played_games[1].score
		else
			return user_played_games[1].score + "-" + user_played_games[0].score
		end
	end

	def update_ranking
		player_1_win = result_of(user_played_games[0].user) == "W" ? 1:0 
    rankings = new_ratings(user_played_games[0].user.ranking, user_played_games[1].user.ranking, player_1_win)

    user_played_games[0].user.update_column :rating, rankings['player1']
    user_played_games[1].user.update_column :rating, rankings['player2']
  end

  def new_ratings(player1_rating,player2_rating,result,k_value=32,should_round=true)
    player1_result = result
    player2_result = 1 - result

    player1_expectation = 1/(1+10**((player2_rating - player1_rating)/400.0))
    player2_expectation = 1/(1+10**((player1_rating - player2_rating)/400.0))

    player1_new_rating = player1_rating + (k_value*(player1_result - player1_expectation))
    player2_new_rating = player2_rating + (k_value*(player2_result - player2_expectation))

    if should_round
      player1_new_rating = player1_new_rating.round
      player2_new_rating = player2_new_rating.round
    end
    new_ratings_hash = Hash.new
    new_ratings_hash['player1'] = player1_new_rating
    new_ratings_hash['player2'] = player2_new_rating

    new_ratings_hash
  end


end

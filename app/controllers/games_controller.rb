class GamesController < ApplicationController
	def index
		@games = current_user.games
	end

	def new
		@game = Game.new
	end 

	def create
		@game = Game.new(game_params)
		find_opponent
		if @game.my_score.to_i > 21 || @game.opponent_score.to_i > 21
			redirect_to new_game_path, notice: "The maximum score is 21"
		elsif @game.my_score.to_i != 21 && @game.opponent_score.to_i != 21
			redirect_to new_game_path, notice: "The maximum score is 21"
		else
			create_user_played_games
			if @game.save
				redirect_to games_path, notice: "The game was created succesfully"
			else
				render action: "new"
			end
		end
	end

	def find_opponent
		@opponent = User.find_by(game_params[:opponent_id])
	end

	def create_user_played_games
		user_played_game_1 = UserPlayedGame.new(user_id: current_user.id, score: game_params[:my_score])
		user_played_game_2 = UserPlayedGame.new(user_id: @opponent.id, score: game_params[:opponent_score])
		@game.user_played_games << [user_played_game_1, user_played_game_2]
	end

	private

	def game_params
		params.require(:game).permit(
		:date_played,
		:opponent_id,
		:my_score,
		:opponent_score,
	)
	end

end

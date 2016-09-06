class CreateUserPlayedGames < ActiveRecord::Migration
  def change
    create_table :user_played_games do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :game, index: true
    	t.string :score
    end
  end
end

class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.date    :date_played
    end
  end
end

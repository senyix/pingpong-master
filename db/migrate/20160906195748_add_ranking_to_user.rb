class AddRankingToUser < ActiveRecord::Migration
  def change
  	add_column :users, :ranking, :integer, default: 0
  end
end

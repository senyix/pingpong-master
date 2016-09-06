class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :user_played_games
  has_many :games, through: :user_played_games

  scope :opponents_scope, ->(user_id) { where.not(id: user_id) }

  def to_label
  	email
  end

  def opponents
  	User.opponents_scope(id)
  end
end

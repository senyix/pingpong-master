class HomeController < ApplicationController
  def index
  	@users = User.order(ranking: :desc)
  end

  def history
  end

  def log
  end
end

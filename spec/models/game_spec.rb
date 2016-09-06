require "rails_helper"

describe Game do 
	it { should validate_presence_of(:date_played) }
	it { should validate_presence_of(:my_score) }
	it { should validate_presence_of(:opponent_score) }

end

require "rails_helper"


feature "Game" do
	scenario "creates a Game" do
		user1 = User.create(email: "senyib@gmail.com", password: "senyix2903")
		user2 = User.create(email: "sen23@gmail.com", password: "senyix2903")
		visit root_path
		fill_in "user_email", with: "senyib@gmail.com"
		fill_in "user_password", with: "senyix2903"
		click_button "Sign in"
		visit new_game_path
		select "sen23@gmail.com", from: "game_opponent_id"
		fill_in "game_my_score", with: 21
		fill_in "game_opponent_score", with: 3
		click_button "Create Game"

		expect(page).to have_text("History")

	end
end

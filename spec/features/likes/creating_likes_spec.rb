require 'rails_helper'
RSpec.describe 'creating likes' do
	before do
		@user = create_user
		log_in @user
		@user.secrets.create(content: 'secret')	
	end
	it 'creates like and displays it both in profile and secret page' do
		visit '/secrets'
		expect(page).to have_text('0 Likes')
		click_button 'Like'
		expect(current_path).to eq('/secrets')
		expect(page).to have_text('1 Like')
		visit "/users/#{@user.id}"
		expect(page).to have_text('1 Like')
	end
end
require 'rails_helper'
RSpec.describe 'displaying likes' do
	before do
		@user = create_user
		log_in @user
		@secret1 = @user.secrets.create(content: 'secret1')
		@secret2 = @user.secrets.create(content: 'secret2')
		Like.create(user: @user, secret: @secret1)
	end
	it 'displays unlike button for secrets already liked' do
		visit '/secrets'
		expect(page).to have_text(@secret1.content)
		expect(page).to have_text('1 Like')
		expect(page).to have_button('Unlike')
		expect(page).to have_text(@secret2.content)
		expect(page).to have_text('0 Likes')
		expect(page).to have_button('Like')
	end
	it 'deletes like and displays the changes in both profile and secrest page' do
		visit '/secrets'
		click_button 'Unlike'
		expect(current_path).to eq('/secrets')
		expect(page).not_to have_button('Unlike')
		expect(page).not_to have_text('1 Like')
		visit "/users/#{@user.id}"
		expect(page).not_to have_text('1 Like')
	end
	it 'creates like and displays it both in profile and secrets page' do
		visit '/secrets'
		click_button 'Like'
		expect(current_path).to eq('/secrets')
		expect(page).not_to have_button('Like')
		expect(page).not_to have_text('0 Likes')
		visit "/users/#{@user.id}"
		expect(page).not_to have_text('0 Likes')
	end
end
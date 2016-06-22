require 'rails_helper'
RSpec.describe 'updating user' do 
	it 'updates user and redirects to profile page' do
		user = create_user
		log_in user
		expect(page).to have_text("dirk")
		click_link 'Edit Profile'
		fill_in 'user[name]', with: 'jason'
		fill_in 'user[password]', with: 'password'
		fill_in 'user[password_confirmation]', with: 'password'
		click_button 'Update'
		expect(page).not_to have_text('dirk')
		expect(page).to have_text('jason')
	end
end
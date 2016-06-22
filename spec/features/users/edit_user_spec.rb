require 'rails_helper'
RSpec.describe 'editing user' do
	it 'displays preopulated form' do
		user = create_user
		log_in user
		click_link 'Edit Profile'
		find_field('user[name]').value.should eq('dirk')
		find_field('user[email]').value.should eq('dirk@mavs.com')
	end
end
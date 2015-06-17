require 'rails_helper'

feature 'Delete question' do

	given(:user) {create(:user)}
	given(:another_user) {create(:user)}
	before { create(:question, user: user) }

	scenario 'Authenticate user can delete their questions' do
		sign_in(user)
		visit questions_path
		click_on 'Delete question'
		expect(page).to_not have_content 'My String'
	end

	scenario 'Authenticate user can not delete another question' do
		sign_in(another_user)	
		visit questions_path
		expect(page).to_not have_content 'Delete question'
	end

end
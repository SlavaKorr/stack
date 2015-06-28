require 'rails_helper'

feature 'User answer', %q{
  User can write
  answer and watch him 
  without reload page
  with using ajax'
} do

  given (:user)     {create(:user)}
  given (:question) {create(:question)}

  scenario 'Authenticated user can write answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'My Answer!'
    click_on 'Send answer'
    expect(current_path).to eq question_path(question)
    within '.answers' do
    page.has_content? "My answer!"
    end
  end

scenario 'Nonauthenticate user can not write answer', js: true do
    visit question_path(question)
    fill_in 'Your answer', with: 'My Answer!'
    click_on 'Send answer'
    within '.answers' do
    page.has_no_content? "My answer!"
    end
  end



end
  
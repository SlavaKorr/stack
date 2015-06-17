require 'rails_helper'

feature 'Create answer' do

  given (:user) {create(:user)}
  given! (:question) {create(:question)}
  

  scenario 'Authenticate user can write answer' do
    sign_in(user)
    visit questions_path
    click_on 'View answers'
    click_on 'Write answer'
    fill_in 'Body', with:'it is my answer'
    click_on 'send answer'
    expect(page).to have_content 'it is my answer'

  end

  scenario 'Nonauthenticate user can not write answer' do
    visit questions_path
    click_on 'View answers'
    click_on 'Write answer'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
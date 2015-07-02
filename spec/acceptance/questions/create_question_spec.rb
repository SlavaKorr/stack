require 'acceptance/acceptance_helper.rb'

feature 'Create question' do

  given(:user) {create(:user)}
  scenario 'Authenticated user can write question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question' 
    fill_in 'Title', with:'titletitletitle'
    fill_in 'Body', with:'bodybodybodybody'
    click_on 'Create'
    save_and_open_page
    expect(page).to have_content 'bodybodybodybody'
    expect(page).to have_content 'titletitletitle'
  end

  scenario 'Non-authenticated user can not write question' do
    visit questions_path
    click_on 'Ask question' 
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
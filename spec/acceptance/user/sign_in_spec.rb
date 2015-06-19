require 'rails_helper'

feature 'User sign in' do
  
  given(:user) {create(:user)}

  scenario 'Registered user try to sign in' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non registered user try to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'wrong_user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'
    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Registered user try to sign out' do
    sign_in(user)
    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unregistered user can sing up' do
    visit root_path
    click_on 'Sign in'
    click_on 'Sign up'
    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
    
  end
end
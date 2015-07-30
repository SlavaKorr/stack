require 'acceptance/acceptance_helper.rb'

  feature 'User can sign in via oauth' do
    scenario "facebook" do 
      visit root_path
      click_on "Sign in"
      #binding.pry
      click_on "Sign in with Facebook"
      mock_auth_hash_facebook
      expect(page). to have_content "Successfully authenticated from Facebook account."
    end
  end

  feature 'User can sign in via oauth' do
    scenario "twitter" do 
      visit root_path
      click_on "Sign in"
      click_on "Sign in with Twitter"
      mock_auth_hash_twitter
      fill_in "Email", with: 'test@twitter.com'
      click_on "Send"
      expect(page). to have_content "Successfully authenticated from Twitter account."
    end
  end



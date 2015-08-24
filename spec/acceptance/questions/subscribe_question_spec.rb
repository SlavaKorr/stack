require 'acceptance/acceptance_helper.rb'

  feature 'User can subscribes on question for the receive new answers on email' do

    given!(:question){create(:question)}
    given (:user) {create(:user)}
    
    scenario "Unregistered user can't see subscribe link", js: true do 
        visit question_path(question)
        expect(page).to_not have_content "Subscribe"
      end
    
    scenario "User can subscribe", js: true do
      sign_in(user)
      visit question_path(question)
      click_on "Subscribe"
      expect(page).to have_content "You subscribe at answers for this question"
    end
  end
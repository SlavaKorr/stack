require 'acceptance/acceptance_helper.rb'

feature 'Vote question' do

  given!(:question){create(:question)}
  given (:user) {create(:user)}
  
    #save_and_open_page

    scenario "Unregistered user can't see vote links" do
      visit question_path(question)
      expect(page).to_not have_content "Vote for this"
    end
    
    scenario "vote UP for the question once", js: true do
      sign_in(user)
      visit question_path(question)
      click_on "+"
      click_on "+"
      within ".rating" do
        expect(page).to have_content "1"
      end
    end

    scenario "User can vote down for the question once", js: true do
      sign_in(user)
      visit question_path(question)
      click_on "-"
      click_on "-"
      within ".rating" do
        expect(page).to have_content "-1"
      end
    end

    scenario "User can choose cancel vote for the question", js: true do
      sign_in(user)
      visit question_path(question)
      click_on "+"
      click_on "cancel"
      within ".rating" do
        expect(page).to have_content "0"
      end
    end

    
end



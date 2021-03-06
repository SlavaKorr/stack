require 'acceptance/acceptance_helper.rb'

feature 'Vote answer' do

  given!(:question){create(:question)}
  given (:answer){create(:answer, question: question)}
  given (:user) {create(:user)}
  
    #save_and_open_page

    scenario "Unregistered user can't see vote links" do
      visit question_path(question)
      expect(page).to_not have_content "Vote for this"
    end
    
    scenario "vote UP for the answer once", js: true do
      answer
      sign_in(user)
      visit question_path(question)
      
      within ".answers" do
        click_on "+"
        click_on "+"
        expect(page).to have_content "1"
      end
    end

    scenario "User can vote down for the answer once", js: true do
      answer
      sign_in(user)
      visit question_path(question)
      
      within ".answers" do
        click_on "-"
        click_on "-"
        expect(page).to have_content "-1"
      end
    end

    scenario "User can choose cancel vote for the answer", js: true do
      answer
      sign_in(user)
      visit question_path(question)
      
      within ".answers" do
        click_on "+"
        click_on "cancel"
        expect(page).to have_content "0"
      end
    end

    
end

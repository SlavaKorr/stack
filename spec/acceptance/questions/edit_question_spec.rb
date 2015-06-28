require 'acceptance/acceptance_helper.rb'

feature 'Editing question' do
  given!(:user){create(:user)}
  given!(:question){create(:question, user: user)}

 before do
      sign_in user
      visit questions_path
    end

    scenario 'User sees Edit link', js: true do
      within '.questions' do
        save_and_open_page
        expect(page).to have_link "Edit"
      end
    end


    scenario 'User can edit your answer', js: true do 
      click_on 'Edit'
      within '.questions' do
      fill_in 'Edit_your_question', with: 'It is my updated question'
      click_on 'Save'
      expect(page).to_not have_content question.body
      expect(page).to_not have_selector 'textarea'
      expect(page).to have_content 'It is my updated question'
      end
    end
  end
      
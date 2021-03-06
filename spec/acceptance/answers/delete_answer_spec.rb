require 'acceptance/acceptance_helper.rb'

feature 'Delete answer' do

given(:user) { create(:user) }
given(:question) { create(:question) }
before { create(:answer, question: question, user: user) }
given(:another_user) { create(:user) }


  scenario 'Authenticate user can delete their answer', js: true do 
    sign_in(user)
    visit questions_path
    click_on 'View answers'
    click_on 'Delete'  
    expect(page).to_not have_content 'MyTextAnswer'
  end

  scenario 'Authenticate user can not delete another answer', js: true do 
    sign_in(another_user)
    visit questions_path
    click_on 'View answers'
    expect(page).to have_content 'MyTextAnswer'
     within '.answers' do
    expect(page).to_not have_content 'Delete'
    end
  end

end
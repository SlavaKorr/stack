require 'acceptance/acceptance_helper.rb'

feature 'anyone can read all questions and all answers' do
  given!(:questions) {create_list(:question, 5)}

  scenario 'reading questions able anyone' do
    visit questions_path
    expect(page).to have_content 'MyString' , count: 5
    expect(page).to have_content 'MyTextttttt' , count: 5
    end
end
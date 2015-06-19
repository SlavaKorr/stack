require 'rails_helper'

feature 'Reading answers and questions' do

  given!(:question) {create(:question)}
  before { create_list(:answer, 3, question: question) }

  scenario 'able anyone' do
    visit questions_path
    click_on 'View answers'
    expect(page).to have_content 'MyTextAnswer', count: 3
  end
end
require 'acceptance/acceptance_helper.rb'

feature "Best answer" do 

  given (:user){create(:user)}
  given (:question){create(:question, user: user)}
  given! (:usual_answer){create(:usual_answer, question: question)}
  given! (:best_answer){create(:best_answer, question: question)}
  given (:another_user) { create(:user) }
  
  scenario "Another user try select best answer", js: true do
    sign_in(another_user)
    visit questions_path
    click_on 'View answers'
    save_and_open_page
    expect(page).to_not have_content "Mark as best"
  end

  scenario "User can see best answer firs in list", js: true do 
    sign_in(user)
    visit question_path(question)
    expect(first('.answers p')).to have_content "This answer is best"
  end

  scenario "Author of question's can choose another best answer", js: true do
    sign_in(user)
    visit question_path(question)
     within "#answer-2" do 
      expect(page).to have_content "This answer is best" 
    end
     within "#answer-1" do 
      click_on "Mark as best" 
      expect(page).to have_content "This answer is best"
    end
    expect(page).to have_content "This answer is best", count: 1
  end

 
end
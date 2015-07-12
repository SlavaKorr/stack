require 'acceptance/acceptance_helper.rb'

feature 'Add file to answer' do

  given(:user) {create(:user)}
  given!(:question){create(:question)}
  given(:another_user){create(:user)}

  before do 
    sign_in(user)
    visit question_path(question)
    fill_in "Your answer", with: "Answer body body"
  end

  scenario "User can add file when asks answer", js: true do 

    click_on "Add file"
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")

    click_on "Send answer"
    within "#answer-1" do
      expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/1/spec_helper.rb"
      expect(page).to have_link "rails_helper.rb", href: "/uploads/attachment/file/2/rails_helper.rb"
    end
  end

  scenario "Author can delete their attached files", js: true do 

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Send answer"
    within "#answer-1" do
      click_on "Delete file"
      expect(page).to_not have_content "spec_helper.rb"
    end
  end

  scenario "Only author can destroy their files", js: true do

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"  
    click_on "Send answer"
    expect(page).to have_content "Delete file"

    click_on "Sign out"
    
    sign_in(another_user)   
    visit question_path(question)
    within "#answer-1" do
      expect(page).to_not have_content "Delete file"
    end
  end

end

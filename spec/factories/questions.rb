FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyTextttttt"
    user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
    user
  end

  factory :update_question, class: "Question" do
    title "MyUpdateTitle"
    body "MyUpdateBody"
    user
  end

end

FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyTextttttt"
    user
  end

factory :second_question, class: "Question"  do
    title "Second_question"
    body "MyTexttttttSecond"
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

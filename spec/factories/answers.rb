FactoryGirl.define do
  
  factory :answer do
    body "MyTextAnswer"
    user
  end

  factory :invalid_answer, class: "Answer" do
    body "M"
    user
  end

  factory :new_answer, class: "Answer" do
    body "MyNEWbodyNEW"
    user
  end

end

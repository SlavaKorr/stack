FactoryGirl.define do
  
  factory :answer do
    body "MyTextAnswer"
  end

  factory :invalid_answer, class: "Answer" do
    body "M"
  end

  factory :new_answer, class: "Answer" do
    body "MyNEWbodyNEW"
  end

end

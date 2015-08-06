FactoryGirl.define do
  
  factory :answer do
<<<<<<< HEAD
	body "MyTextttttt"
=======
    body "MyTextAnswer"
    question
    user
  end

  factory :best_answer, class: "Answer" do
    body "It_is_BEST_answer"
    user
    association :question
    best_answer true  
  end

  factory :usual_answer, class: "Answer" do
    body "It_is_usual_answer"
    user
    association :question
    best_answer false  
  end


  factory :invalid_answer, class: "Answer" do
    body "M"
    user
  end

  factory :new_answer, class: "Answer" do
    body "MyNEWbodyNEW"
    user
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd
  end

  factory :invalid_answer, class: "Answer" do
	body "M"
  end

  factory :new_answer, class: "Answer" do
	body "MyNEWbodyNEW"
  end
end

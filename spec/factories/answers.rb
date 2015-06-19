FactoryGirl.define do
  factory :answer do
	body "MyTextttttt"
  end

  factory :invalid_answer, class: "Answer" do
	body "M"
  end

  factory :new_answer, class: "Answer" do
	body "MyNEWbodyNEW"

	factory :only_answer, class: "Answer" do
	body "MyNEWbodyNEW"
  end
  end
end

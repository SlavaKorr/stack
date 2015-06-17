FactoryGirl.define do
	factory :question do
		title "MyString"
		body "MyTextttttt"
	end

	factory :invalid_question, class: "Question" do
		title nil
		body nil
	end

	factory :update_question, class: "Question" do
		title "MyUpdateTitle"
		body "MyUpdateBody"
	end

end

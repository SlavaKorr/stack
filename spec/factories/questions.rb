FactoryGirl.define do
  factory :question, class: "Question"  do
    title "MyString"
<<<<<<< HEAD
	body "MyTextttttt"
=======
    body "MyTextttttt"
    user
  end

factory :second_question, class: "Question"  do
    title "Second_question"
    body "MyTexttttttSecond"
    user
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd
  end

  factory :invalid_question, class: "Question" do
    title nil
<<<<<<< HEAD
	body nil
  end

factory :update_question, class: "Question" do
    title "MyUpdateTitle"
	body "MyUpdateBody"
=======
    body nil
    user
  end

  factory :update_question, class: "Question" do
    title "MyUpdateTitle"
    body "MyUpdateBody"
    user
>>>>>>> 9cbdb60464406cd6c424b81b269c633daf750abd
  end

end

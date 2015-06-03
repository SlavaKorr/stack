require 'rails_helper'

describe AnswersController do

  let(:question) { create(:question) }
  let(:answer)   { create(:answer, question: question)}
  

describe 'GET #index' do
	 before { get :index, question_id: question }

	it 'show all answers belong to question' do
	expect(assigns(:answers)).to match_array(question.answers)	
	end

	it 'render template index' do
	expect(response).to render_template :index
	end
end


describe 'GET #new' do
	before { get :new, question_id: question }

 	it 'create new question' do
  	expect(assigns(:answer)).to be_a_new(Answer)
  	end

  	it 'render template new' do
  	expect(response).to render_template :new
  	end
end


describe 'POST #create' do

  context 'sucsesful create' do
	it 'create answer and save in db' do
	expect {post :create, question_id: question, answer: attributes_for(:answer)}.to change(question.answers, :count)
	end

	it 'redirect to page with new answer' do
	post :create, question_id: question, answer: attributes_for(:answer)
	expect(response).to redirect_to(assigns(:question))
	end
  end

  context 'UNsucsessful create' do
  	it 'does not save invalid answer in db' do
  	expect {post :create, question_id: question, answer: attributes_for(:invalid_answer)}.to_not change(question.answers, :count)
  	end

  	it 'render template with invalid answer' do
  	post :create, question_id: question, answer: attributes_for(:invalid_answer)
	expect(response).to render_template :new
  	end
  end

end


describe 'DELETE #destroy' do

    it 'delete answer' do
    answer
    expect { delete :destroy, question_id: question, id: answer }.to change(Answer, :count).by(-1)
    end

    it 'redirect to question' do
    delete :destroy, question_id: question, id: answer
    expect(response).to redirect_to question
	end

end

end
require 'rails_helper'

describe QuestionsController do

	let(:question) {create(:question)}
describe 'GET index' do	
	let(:questions) {create_list(:question, 2)}
    before { get :index }
	
	it 'show all questios on index' do
	expect(assigns(:questions)).to match_array(@questions)
	end

	it 'render template index'	do
	expect(response).to render_template :index	
	end
end	


describe 'GET #show' do
	before {get :show, id: question}

	it 'show question' do
	expect(assigns(:question)).to eq question 
	end

	it 'render template question' do
	expect(response).to render_template :show
 	end
end


describe 'GET #new' do
	before { get :new }

 	it 'create new question' do
  	expect(assigns(:question)).to be_a_new(Question)
  	end

  	it 'render template new' do
  	expect(response).to render_template :new
  	end
end


describe 'GET #edit' do
  	before {get :edit, id: question}

	it 'edit question' do
	expect(assigns(:question)).to eq question 
 	end

  	it 'render template edit' do
  	expect(response).to render_template :edit
	end
end

describe 'POST #create' do
  
  context 'create question with invalid attributes' do
  	it 'create question and save in database' do
	expect { post :create, question: attributes_for(:question) }.to change(Question, :count)
	end

	it 'redirect to a new question' do
	post :create, question: attributes_for(:question)
	expect(response).to redirect_to question_path(assigns(:question))
	end
 end

  context 'create question with invalid attributes' do
  	it 'does not save save the question' do
  	expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
  	end	

  	it 'render new template with invalid attributes' do

  	post :create, question: attributes_for(:invalid_question)
  	expect(response).to render_template :new
  	end
  end
end


describe 'PATCH #update' do
  
  context 'sucessful edit' do
  	it 'update question with valid attributes' do
  	patch :update, id: question, question: attributes_for(:question)
  	expect(assigns(:question)).to eq question 
  	end

  	it 'exactly update question' do
  	patch :update, id: question, question: attributes_for(:update_question)
  	question.reload
  	expect(assigns(:question)).to eq question 
	end

  	it 'redirect to updated question' do 
  	patch :update, id: question, question: attributes_for(:question)
  	expect(response).to redirect_to question
  	end
  
  context 'invalid attributes' do
  	before {patch :update, id: question, question: attributes_for(:invalid_question)}

  	it 'does not change question attributes' do
  	question.reload
  	expect(assigns(:question)).to eq question 
  	end

  	it 'render temlate edit with invalid attributes' do
  	expect(response).to render_template :edit
  	end
  end	
end

describe 'DELETE #destroy' do
	before {question}

	it 'delete question' do
	expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
	end

	it 'redirect to index' do
	delete :destroy, id: question 
	expect(response).to redirect_to questions_path
	end
end

end
end
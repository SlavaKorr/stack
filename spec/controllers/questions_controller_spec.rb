require 'rails_helper'

  describe QuestionsController do

  let(:question) {create(:question)}

    describe 'GET index' do 
      let(:questions) {create_list(:question, 2)}
      before { get :index }
    
      it 'show all questions on index' do
        expect(assigns(:questions)).to match_array(@questions)
      end

      it 'render template index'  do
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
    sign_in_user

    before { get :new }

      it 'create new question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'render template new' do
        expect(response).to render_template :new
      end
  end


  describe 'GET #edit' do

    let(:question) { create(:question, user: @user) }
    sign_in_user
    before {get :edit, id: question}

      it 'edit question' do
        expect(assigns(:question)).to eq question 
      end

      it 'render template edit' do
        expect(response).to render_template :edit
      end
  end

  describe 'POST #create' do

    sign_in_user
    let(:question) { create(:question, user: @user) }
    let(:invalid_question) { create(:invalid_question, user: @user) }

    context 'create question with valid attributes can only authorised user' do

      it 'create question and save in database' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirect to a new question' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
        expect(question.user.id).to eq @user.id
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
      
    sign_in_user
    context 'sucessful edit' do

      let(:question) { create(:question, user: @user) }
      it 'update question with valid attributes' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question 
      end

      it 'exactly update question' do
        patch :update, id: question, question: {title: 'new title', body: 'new bodynew body'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new bodynew body' 
        expect(question.user.id).to eq @user.id
      end

      it 'redirect to updated question' do 
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end

    context 'invalid attributes' do
      it 'try update question' do
        patch :update, id: question, question: {title: 'nil', body: 'nil'}
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyTextttttt' 
      end

      it 'render temlate edit with invalid attributes' do
        expect(response).to render_template :edit
      end
    end 
  end

  describe 'DELETE #destroy' do

    context 'Authenticate user can delete only their questions' do
      sign_in_user
      let(:question) { create(:question, user: @user) }
      before {question}

      it 'delete question can only owner' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirect to index' do
      delete :destroy, id: question 
      expect(response).to redirect_to questions_path
      end
    end

    context "Authenticate user can not delete other questions" do
      let(:author_user) { create(:user) }
      let(:question) { create(:question, user: author_user) }
      before { question }
      sign_in_user

      it 'does not delete question' do
      expect{ delete :destroy, id: question }.to_not change(Question, :count)
      end

      it "redirect to root_path" do
      delete :destroy, id: question
      expect(response).to redirect_to root_path
      end
    end

    context 'Non-authecated user can not delete any questions' do
      it 'try to delete' do
      delete :destroy, id: question
      expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
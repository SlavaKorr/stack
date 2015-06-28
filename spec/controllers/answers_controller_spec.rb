require 'rails_helper'

  describe AnswersController do
    let(:user)  { create(:user) }
    let!(:question) { create(:question) }
    let(:answer)   { create(:answer, question: question, user: @user)}
   

  describe 'POST #create' do
 sign_in_user
  
    context 'Sucsesful create answer able only authenticate user' do
      it 'create answer and save in db' do
        expect {post :create, question_id: question, answer: attributes_for(:answer), format: :js}.to change(question.answers, :count).by(1)
      end

      it 'promice that new answer have user_id equal current_user_id' do 
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer).user_id).to eq (subject.current_user.id)
      end



      it 'Redirect to page with new answer' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create 
      end
    end

    context 'UNsucsessful create' do
      it 'does not save with only_answer' do
        expect {post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js}.to_not change(Answer, :count)
    end

      it 'render template with invalid answer' do     
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create 
      end
    end
  end


  describe 'PATCH #update' do
      
    sign_in_user
    
      it 'update answer with valid attributes' do
       patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
       expect(assigns(:answer)).to eq answer
      end

      it 'exactly update answer' do
        patch :update, id: answer, question_id: question, answer: {body: 'new bodynew body'}, format: :js
        answer.reload
        expect(answer.body).to eq 'new bodynew body' 
        expect(answer.user.id).to eq @user.id
      end

      it 'render to update template' do 
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :update
      end
  end

  describe 'DELETE #destroy' do
    
      sign_in_user
      let(:question) { create(:question) }
      let(:answer) { create(:answer, question: question, user: @user)}
      before { answer }

    context 'Authenticate user can delete their answer' do

      it 'delete answer' do
        expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'Authenticate user can not delete another answer' do

      let(:question) { create(:question) }
      let(:author) { create(:user) }
      let(:answer) { create(:answer, question: question, user: author) }
      before { answer }
      sign_in_user

      it 'try to delete answer' do
        expect { delete :destroy, id: answer, format: :js }.to_not change(Answer, :count)
      end

      it "redirect to root path" do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template :destroy
      end
    end
  end

  describe 'PATCH #best' do 

    context "When user question's author" do 

      let!(:question_user) { create(:question, user: user) }
      let!(:answer)   { create(:answer, question: question_user)}
      
      before do
        sign_in(user)
        patch :best,  id: answer, format: :js
      end
      
      it "Question's author can select best answer" do 
        answer.reload
        expect(answer.best_answer).to eq true
      end

      it "Render template :best" do
        expect(response).to render_template :best
      end

      it "Question's author can select best another answer" do
        answer.reload
        expect(answer.best_answer).to eq true

        answer_next = create(:answer, question: question_user)
        patch :best,  id: answer_next, format: :js
        answer.reload
        answer_next.reload

        expect(answer.best_answer).to eq false
        expect(answer_next.best_answer).to eq true
      end
    end

    context "When user non question's author" do 
   
      let!(:question) { create(:question, user: user) }
      let!(:answer)   { create(:answer, question: question)}
      sign_in_user

      it "try to select best answer" do 
        patch :best,  id: answer, format: :js
        answer.reload
        expect(answer.best_answer).to eq false
      end
    end
  end
end


require 'rails_helper'

  describe AnswersController do
    let(:user){ create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer)   { create(:answer, question: question, user: user)}
   # let(:invalid_answer)   { create(:invalid_answer, question: question)}
   

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


  describe 'DELETE #destroy' do
    
      sign_in_user
      let(:question) { create(:question) }
      let(:answer) { create(:answer, question: question, user: @user)}
      before { answer }

    context 'Authenticate user can delete their answer' do

      it 'delete answer' do
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, id: answer
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'Authenticate user can not delete another answer' do

      let(:question) { create(:question) }
      let(:author) { create(:user) }
      let(:answer) { create(:answer, question: question, user: author) }
      before { answer }
      sign_in_user

      it 'try to delete answer' do
        expect { delete :destroy, id: answer }.to_not change(Answer, :count)
      end

      it "redirect to root path" do
        delete :destroy, id: answer
        expect(response).to redirect_to root_path
      end
    end
  end

end


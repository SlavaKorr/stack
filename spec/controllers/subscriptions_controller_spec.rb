require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  let(:user)  { create(:user) }
  let!(:question)  { create(:question, user: user) }


  describe "POST #create" do 
    let(:request) { post :create, question_id: question.id, format: :js }
    before do 
      sign_in(user)
    end 


    it "User can subscribe" do 
      expect { request }.to change(Subscription, :count).by 1
    end

    it "send status 200 OK" do 
      request
      expect(response).to have_http_status 200
    end

  end

end

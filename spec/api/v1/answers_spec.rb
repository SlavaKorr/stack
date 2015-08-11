require 'rails_helper'

describe 'Answers API' do
  
  let!(:question) { create(:question) }


  describe 'GET /index' do

    context 'unauthorized' do
      it "return 401 status if token empty" do
        get "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it "return 401 status if token wrong" do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '12345678'
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let(:access_token) { create(:access_token) }
      let!(:answers) { create_list(:answer, 2, question: question) }
      let(:answer) { answers.first }

      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'return 200 status code' do
        expect(response).to be_success
      end

      it 'return list of answers' do
        expect(response.body).to have_json_size(2).at_path("answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer include #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end



  describe 'GET /show' do

    let(:answer) { create(:answer) }

    context 'unauthorized' do
      it "return 401 status if token empty" do
        get "/api/v1/answers/#{answer.id}", format: :json
        expect(response.status).to eq 401
      end

      it "return 401 status if token wrong" do
        get "/api/v1/answers/#{answer.id}", format: :json, access_token: '12345678'
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let!(:access_token) { create(:access_token) }
      let!(:comments) { create_list(:comment, 2, commentable: answer) }
      let!(:comment) { comments.last }
      let!(:attachments) { create_list(:attachment, 2, attachable: answer) }
      let!(:attachment) { attachments.last }


      before { get "/api/v1/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it "returns 200 status code" do
        expect(response).to be_success
      end

      %w(id body created_at updated_at body).each do |attr|
        it "answer contain #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("one_answer/#{attr}")
        end
      end

      context "comments" do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("one_answer/comments")
        end

        %w(id comment_body created_at updated_at).each do |attr|
          it "contain #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("one_answer/comments/0/#{attr}")
          end
        end
      end

      context "attachments" do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("one_answer/attachments")
        end

        it "contain url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("one_answer/attachments/0/url")
        end
      end
    end
  end



  describe "POST /create" do

    context "unauthorized" do
      it "return 401 status if there is no access_token" do
        post "/api/v1/questions/#{question.id}/answers", format: :json, answer: attributes_for(:answer)
        expect(response.status).to eq 401
      end

      it "return 401 status if access_token is invalid" do
        post "/api/v1/questions/#{question.id}/answers", format: :json, answer: attributes_for(:answer),
         access_token: '12345678'
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      context "with valid attributes" do
        it "return 200 status code" do
          post "/api/v1/questions/#{question.id}/answers", format: :json, answer: attributes_for(:answer), 
          access_token: access_token.token
          expect(response).to have_http_status :created
        end

        it "save new answer in the database" do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json, answer: attributes_for(:answer), 
                   access_token: access_token.token }.to change(Answer, :count).by(1)
        end

        it "create answer to the question" do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token,
                   answer: attributes_for(:answer)}.to change(question.answers, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "return 401 status code" do
          post "/api/v1/questions/#{question.id}/answers", format: :json, answer: attributes_for(:invalid_answer),
          access_token: access_token.token
          expect(response).to have_http_status :unprocessable_entity
        end

        it "don't save new answer in the database" do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json, 
                   answer: attributes_for(:invalid_answer), access_token: access_token.token }.to_not change(Answer, :count)
        end

        it "don't create answer to the question" do
          expect { post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token,
                   answer: attributes_for(:invalid_answer)}.to_not change(question.answers, :count)
        end
      end
    end
  end
end

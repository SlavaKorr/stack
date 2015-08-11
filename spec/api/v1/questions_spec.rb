 require 'rails_helper'

  describe "Questions API" do 


    describe "GET /index" do
      context "unauthorized" do 

        it "return 401 status if token empty" do
          get '/api/v1/questions', format: :json
          expect(response.status).to eq 401
        end

        it "return 401 status if token wrong" do
          get '/api/v1/questions', format: :json, access_token: '112233'
          expect(response.status).to eq 401
        end
      end

      context "authorized" do
        let(:access_token) { create(:access_token) }
        let!(:questions) { create_list(:question, 3) }
        let(:question) { questions.first }
        let!(:answer) { create(:answer, question: question) }


        before { get '/api/v1/questions', format: :json, access_token: access_token.token }

        it "return status 200 OK" do 
          expect(response).to be_success
        end

        it "return list of questions" do 
          expect(response.body).to have_json_size(3).at_path("questions")
        end

        %w( id body title created_at updated_at ).each do |attr| 
          it "questions object contains #{attr}" do 
            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
          end
        end

        context 'answers' do
          it 'included in question object' do
            expect(response.body).to have_json_size(1).at_path("questions/0/answers")
          end

          %w(id body created_at updated_at).each do |attr|
            it "contains #{attr}" do
              expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
            end
          end
        end
      end
    end



    describe "GET /show" do
      let(:question) { create(:question) }
      context "unauthorized" do 
        it "return 401 status if token empty" do
          get "/api/v1/questions/#{question.id}", format: :json
          expect(response.status).to eq 401
        end

        it "return 401 status if token wrong" do
          get "/api/v1/questions/#{question.id}", format: :json, access_token: '112233'
          expect(response.status).to eq 401
        end
      end

      context 'authorized' do
        let!(:access_token) { create(:access_token) }
        let!(:comments) { create_list(:comment, 2, commentable: question) }
        let!(:comment) { comments.last }
        let!(:attachments) { create_list(:attachment, 2, attachable: question) }
        let!(:attachment) { attachments.last }

        before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

        it 'return 200 status code' do
          expect(response).to be_success
        end

        %w(id title created_at updated_at body).each do |attr|
          it "question contains #{attr}" do
            expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("one_question/#{attr}")
          end
        end

        context 'comments' do
          it 'included in question object' do
            expect(response.body).to have_json_size(2).at_path("one_question/comments")
          end

          %w(id comment_body created_at updated_at).each do |attr|
            it "contains #{attr}" do
              expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("one_question/comments/0/#{attr}")
            end
          end
        end

        context 'attachments' do
          it 'included in question object' do
            expect(response.body).to have_json_size(2).at_path("one_question/attachments")
          end

          it "contain url" do
            expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("one_question/attachments/0/url")
          end
        end
      end
    end



  describe "POST /create" do
    context "unauthorized" do

      it "return 401 status if token empty" do
        post "/api/v1/questions", format: :json, question: attributes_for(:question)
        expect(response.status).to eq 401
      end

      it "return 401 status if token wrong" do
        post "/api/v1/questions", format: :json, question: attributes_for(:question), access_token: '12345678'
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      context "with valid attributes" do
        it "return 201 status code" do
          post "/api/v1/questions", format: :json, question: attributes_for(:question), access_token: access_token.token
          expect(response).to have_http_status :created
        end

        it "save new question in the database" do
          expect { post "/api/v1/questions", format: :json, question: attributes_for(:question),
                   access_token: access_token.token }.to change(Question, :count).by(1)
        end

        it "create question to the user" do
          expect { post "/api/v1/questions", format: :json, access_token: access_token.token,
                   question: attributes_for(:question)}.to change(me.questions, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "return 401 status code" do
          post "/api/v1/questions", format: :json, question: attributes_for(:invalid_question), access_token: access_token.token 
          expect(response).to have_http_status :unprocessable_entity
        end

        it "don't save the new question in the database" do
          expect { post "/api/v1/questions", format: :json, question: attributes_for(:invalid_question),
                   access_token: access_token.token }.to_not change(Question, :count)
        end

        it "don't create question to the user" do
          expect { post "/api/v1/questions", format: :json, access_token: access_token.token,
                   question: attributes_for(:invalid_question)
          }.to_not change(me.questions, :count)
        end
      end
    end
  end
end





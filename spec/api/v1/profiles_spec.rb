  require 'rails_helper'

  describe "Profille API" do 
    describe "GET /me" do
      context "unauthorized" do 

        it "return 401 status if token empty" do
          get '/api/v1/profiles/me', format: :json
          expect(response.status).to eq 401
        end

        it "return 401 status if token wrong" do
          get '/api/v1/profiles/me', format: :json, access_token: '112233'
          expect(response.status).to eq 401
        end
      end

      context "authorized" do
        let(:me) { create(:user) }
        let(:access_token) { create(:access_token, resource_owner_id: me.id) }

        before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

        it "return status 200 OK" do 
          expect(response).to be_success
        end

        %w( id email created_at updated_at ).each do |attr|
          it "contains #{attr}" do 
            expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
          end
        end

        %w( password encrypted_password ).each do |attr|
          it "does not have #{attr} in query" do 
            expect(response.body).to_not have_json_path(attr)
          end
        end
      end
    end



    describe "GET /index" do
      context "unauthorized" do 

        it "return 401 status if token empty" do
          get '/api/v1/profiles/', format: :json
          expect(response.status).to eq 401
        end

        it "return 401 status if token wrong" do
          get '/api/v1/profiles/', format: :json, access_token: '112233'
          expect(response.status).to eq 401
        end
      end

      context "authorized" do
        let(:me) { create(:user) }
        let!(:users) { create_list(:user, 3) }
        let(:access_token) { create(:access_token, resource_owner_id: me.id) }

        before { get '/api/v1/profiles/', format: :json, access_token: access_token.token }

        it "return status 200 OK" do 
          expect(response).to be_success
        end

        %w( id email created_at updated_at ).each do |attr|
          it "contains #{attr}" do 
            expect(response.body).to be_json_eql(users.to_json).at_path("profiles")
            expect(response.body).to_not include_json(me.to_json).at_path("profiles")

          end
        end

        %w( password encrypted_password ).each do |attr|
          it "does not have #{attr} in query" do 
            expect(response.body).to_not have_json_path("profiles/#{attr}")
          end
        end
      end
    end


  end

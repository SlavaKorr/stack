  require 'rails_helper'

  describe "Profille API" do 
    describe "GET /me" do
      
      it_behaves_like "API Authenticable"

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
      def do_request(options = {})
        get '/api/v1/profiles/me', { format: :json }.merge(options)
      end
    end



    describe "GET /index" do
       it_behaves_like "API Authenticable"
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
            usr = users.first 
            expect(response.body).to be_json_eql(usr.send(attr.to_sym).to_json).at_path("profiles/0/#{attr}")
            expect(response.body).to_not include_json(me.to_json)

          end
        end

        %w( password encrypted_password ).each do |attr|
          it "does not have #{attr} in query" do 
            expect(response.body).to_not have_json_path("profiles/#{attr}")
          end
        end
      end
      def do_request(options = {})
        get '/api/v1/profiles/', { format: :json }.merge(options)
      end
    end


  end

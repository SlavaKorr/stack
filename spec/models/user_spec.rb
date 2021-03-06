require 'rails_helper'

RSpec.describe User do
  it { should have_many :votes }
  it { should have_many :answers }
  it { should have_many :comments }
  it { should have_many :questions }
  it { should have_many :subscriptions}
  it { should have_many :authorizations }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe ".find_for_oauth" do 
    let!(:user){create(:user)}
    let(:auth){OmniAuth::AuthHash.new(provider: 'facebook', uid: '1234567' )}
    
    context "User already has authorization" do 
      it "give user" do 
        user.authorizations.create(provider: 'facebook', uid: '1234567' )
        expect(User.find_for_oauth(auth)). to eq user
      end
    end
    
    context "User has no authorization" do 
      context "user already exist" do
        let(:auth){OmniAuth::AuthHash.new(provider: 'facebook', uid: '1234567', info: { email: user.email })}
        it "does't create user" do 
          expect {User.find_for_oauth(auth)}. to_not change(User, :count)
        end
        it "create authorization for user" do 
          expect {User.find_for_oauth(auth)}. to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.find_for_oauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it "return user" do 
          expect(User.find_for_oauth(auth)). to eq user
        end
      end
    end


    context "user dos't exist" do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'facebook@user.com' }) }

      it "create new user" do
        expect { User.find_for_oauth(auth) }.to change(User, :count).by(1)
      end
        
      it "return new user" do
        expect(User.find_for_oauth(auth)).to be_a(User)
      end

      it "compare user email" do
        user = User.find_for_oauth(auth)
        expect(user.email).to eq auth.info[:email]
      end

      it "create authorization for user" do
        user = User.find_for_oauth(auth)
        expect(user.authorizations).to_not be_empty
      end

      it "create authorization with provider and uid" do
        authorization = User.find_for_oauth(auth).authorizations.first
        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
    end

    context "without email in omniauth." do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '123456', info: { email: nil }) }

      it "should return User.new if email in oauth hash nil and if user hasn't in authorization" do 
        expect(User.find_for_oauth(auth)). to be_a(User)
      end

      it "couldn't create in authorization without email" do 
          expect {User.find_for_oauth(auth)}. to_not change(user.authorizations, :count)
      end
    end
  end

  describe ".send_daily_digest" do
    let(:users) { create_list(:user, 2) } 
    it "should send daily digest to all users" do 
      users.each { |user| expect(DailyMailer).to receive(:digest).with(user).and_call_original }
      User.send_daily_digest
    end

  end


end

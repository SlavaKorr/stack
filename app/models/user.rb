  class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, 
        :omniauthable, omniauth_providers: [:facebook, :twitter]
  
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  def self.find_for_oauth(auth)
      authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
      return authorization.user if authorization

      return User.new unless auth.info.email.present?

      email = auth.info.email
      user = User.where(email: email).first

    if user
      user.create_authorization(auth)
    else
      user = generate_user(email)
      user.create_authorization(auth)
    end
      user
  end


  def self.generate_user(email)
    password = Devise.friendly_token[0, 20]
    user = User.create!(email: email, password: password, password_confirmation: password)
  end


  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end


  def self.send_daily_digest
    find_each.each do |user|
    DailyMailer.digest(user).deliver_later
    end
  end

 
end


 

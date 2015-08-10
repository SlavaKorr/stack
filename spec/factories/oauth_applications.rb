FactoryGirl.define do 
  factory :oauth_application, class: Doorkeeper::Application do
    name "testA"
    redirect_uri "urn:ietf:wg:oauth:2.0:oob"
    uid "123456789"
    secret "234567890"
  end
end
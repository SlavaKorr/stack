module OmniauthMacros


def mock_auth_hash_facebook  
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'provider' => 'facebook',
      'uid' => '1235456',
      'info' => {
      'email' => 'test@facebook.com',
      'name' => 'mockuser' }})
  end

  def mock_auth_hash_twitter  
     OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'provider' => 'twitter',
      'uid' => '1235456',
      'info' => {
      'name' => 'mockuser' }})
  end

end

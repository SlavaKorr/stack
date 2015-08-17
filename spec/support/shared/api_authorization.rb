shared_examples_for "API Authenticable" do 

  context "unauthorized" do 
    it "return 401 status code if there is no access_token" do 
      do_request
      expect(response.status). to eq 401
    end

    it "return 401 status code if there is no access_token" do 
      do_request(access_token: '12345')
      expect(response.status). to eq 401
    end
  end
end
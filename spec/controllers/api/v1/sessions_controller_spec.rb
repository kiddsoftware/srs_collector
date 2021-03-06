require 'spec_helper'

describe API::V1::SessionsController do
  let!(:user) do
    User.create!(email: "test@example.com", password: "password",
                 password_confirmation: "password")
  end

  describe "POST 'create'" do
    it "logs the user in if the password is correct" do
      credentials = {
        email: user.email,
        password: user.password
      }
      xhr :post, 'create', format: 'json', session: credentials
      response.should be_success
      session[:user_id].should == user.id
      json['user']['email'].should == user.email
      json['csrf_token'].should_not be_nil
    end

    it "doesn't log the user in if the password is incorrect" do
      credentials = {
        email: user.email,
        password: "incorrect"
      }
      xhr :post, 'create', format: 'json', session: credentials
      response.should_not be_success
      session[:user_id].should == nil
    end
  end

  describe "POST 'destroy'" do
    it "logs the user out" do
      sign_in(user)
      xhr :post, 'destroy', format: 'json'
      response.should be_success
      session[:user_id].should be_nil
    end
  end
end

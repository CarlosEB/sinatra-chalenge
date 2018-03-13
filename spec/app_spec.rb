require './app.rb'
require 'rack/test'

describe 'TrackApp App', :type => :controller do
    include Rack::Test::Methods
    
    def app
      TrackApp.new
    end
    
    it "display home page" do 
      get '/'
      expect(last_response.body).to include("Welcome")
      expect(last_response.status).to eq(200)
    end
    
    it "Display user stats" do 
      get '/users_stats'
      expect(last_response.status).to eq(200)
    end

    it "Add user succes" do 
      post '/add_user', { :name => "Carlos", :email => "ceb_12345_mail_test@gmail.com" }
      expect(last_response.status).to eq(200)
      User.find_by(:email => "ceb_12345_mail_test@gmail.com").destroy
    end
    
    it "Add user fail" do 
      post '/add_user', { :name => "Carlos", :email => "" }
      expect(last_response.status).to eq(200)
    end
    
    it "Add user stats success" do 
      post '/add_user', { :name => "Carlos", :email => "ceb_12345_mail_test@gmail.com" }
      post '/add_stats', { :url => "http://www.test.com", :email => "ceb_12345_mail_test@gmail.com" }
      expect(last_response.status).to eq(200)
      UserStatistic.find_by(:email => "ceb_12345_mail_test@gmail.com").destroy
      User.find_by(:email => "ceb_12345_mail_test@gmail.com").destroy
    end
    
    it "Add user stats fail" do 
      post '/add_stats', { :url => "http://www.test.com", :email => "ceb_12345_mail_test@gmail.com" }
      expect(last_response.status).to eq(500)
    end
    
end
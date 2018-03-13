require 'sinatra'
require 'sinatra/base'
require "sinatra/reloader"
require 'sprockets'
require 'slim'
require 'uglifier'
require 'sass'
require 'coffee-script'
require 'execjs'
require "sinatra/activerecord"
require './config/environments' #Database configuration

class TrackApp < Sinatra::Base

  # Reload files after changes.
  register Sinatra::Reloader
  enable :reloader

  # Initialize new sprockets environment
  set :environment, Sprockets::Environment.new

  # Append assets paths
  environment.append_path "app/assets/stylesheets"
  environment.append_path "app/assets/javascripts"
  environment.append_path "app/assets/images"

  # Compress assets
  environment.js_compressor  = :uglify
  environment.css_compressor = :scss

  # Paths
  configure do
      set :views, "#{settings.root}/app/views"
  end

  # Get assets
  get "/app/assets/*" do
    env["PATH_INFO"].sub!("/app/assets", "")
    settings.environment.call(env)
  end

  # Load models and helpers
	current_dir = Dir.pwd
	["app/models","app/helpers"].each do |folder|
		Dir["#{current_dir}/#{folder}/*.rb"].each { |file| require file }
	end

  # Access to plugin	
  get '/plugin/v1/:filename' do |filename|
    send_file "public/plugins/#{filename}"
  end

  # Main page
  get "/" do
    slim :index, :layout => :"/layout/_layout"
  end
  
  # Statistics page
  get "/users_stats" do
    @users = User.all
    slim :users_stats, :layout => :"/layout/_layout"
  end
  
  # Filter the 10 last urls browsed by user
  post "/users_stats" do
    @users = User.all
    @stats = nil
    if (params.has_key?("email"))
      @user = User.find_by(:email => params[:email])
      @stats = @user.user_statistics.last(10).reverse
    end
    
    slim :users_stats, :layout => :"/layout/_layout"
  end
  
  # Add users in the database
  post "/add_user" do
    @user = User.new(:name => params[:name], :email => params[:email].downcase)
    @user.save
  end
  
  # Add statistics in the database
  post "/add_stats" do
    @user_stats = UserStatistic.new(:email => params[:email].downcase, :url => params[:url])
    @user_stats.save
  end

end
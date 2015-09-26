require 'sinatra'
require 'sinatra/activerecord'

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'

set :database, "sqlite3:microblog3_db.sqlite3"
set	:sessions, true
use Rack::Flash, :sweep => true

helpers do
	def current_user
		session[:user_id].nil? ? nil : User.find(session[:user_id])
	end
	def display_one
		"1"
	end
end





# def current_user
# 		if session[:user_id]
# 			@current_user = User.find(session[:user_id])
# 		end
# 	end


get '/' do 
	session[:user_id] = nil
	erb :index
end

get  '/signin' do
	erb :signin
end

get "/signin/alert" do
	flash[:notice] = ' please log in newbie... '
	erb :signin
end

post "/signin/alert" do
	flash[:notice] = ' please log in newbie... '
	erb :signin
end	



post '/signin' do
	username = params[:username]
	pass = params[:password]
	@user = User.where(username: username).first
	if @user
		if @user.password == pass
			session[:user_id] = @user.id
			redirect "/profile/#{@user.id}"
		end
	else
		redirect "/signup"
#		flash[:alert] = "Sorry, that user doesn't exist. Feel free to sign up."
	end
end


get '/profile/:id' do
	@user = User.find(params[:id])
	erb :profile
end


post '/profile' do
	@user = User.find(session[:user_id])
end



get '/signout' do
	@user = User.find(params[:id])
	erb	:signout
end


post '/signout' do
	@user = User.find(session[:user_id])
	flash[:notice] = "goodbye..."
	session[:user_id] = nil
end


get '/signup' do
	erb	:signup
end


post '/signup' do
	session[:user_id] = nil
	user = params[:username]
	if User.where(params[:username])
		flash[:notice] = 'Sorry that username is taken. Choose another.'
		redirect '/signup'
	else
		flash[:notice] = 'New gossiper accepted. Please Log In'
		@user = User.create(username: params[:username], password: params[:password])
		redirect '/'
	end

		
end
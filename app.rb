require 'sinatra'
require 'sinatra/activerecord'

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'

set :database, "sqlite3:microblog3_db.sqlite3"
enable	:sessions
use Rack::Flash, :sweep => true

def current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])
		end
	end


get '/' do 
	session[:user_id] = nil
	erb :index
end

get  '/signin' do
	erb :signin
end

post '/signin' do
	flash[:notice] = ' one of us... '
	username = params[:username]
	pass = params[:password]
	@user = User.where(username: username).first
	if @user
		if @user.password == pass
		session[:user_id] = @user.id
		redirect '/profile'
		end
	else
		redirect '/signup'
	end
end


get '/profile' do
  erb :profile
end



post '/profile' do
	@user = User.find(session[:user_id])
	@name = @user.username
	@session = User.find(session[:username])
	puts current_user
end



get '/signout' do
	erb	:signout
end


post '/signout' do
	flash[:notice] = "you'll be back..."
	session[:user_id] = nil
end


get '/signout' do
	erb	:signout
end


post '/signout' do
	flash[:notice] = "you'll be back..."
	session[:user_id] = nil
end



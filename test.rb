#used to test signup form pages


require 'sinatra'
require 'sinatra/activerecord'

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'

set :database, "sqlite3:microblog3_db.sqlite3"
set	:sessions, true
use Rack::Flash, :sweep => true


get  '/signin' do
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
		flash[:notice] = "Sorry, that user doesn't exist. Feel free to sign up."
		redirect "/signup"
		end
	end



get '/signup' do
	erb	:signup
end

post '/signup' do
	username = params[:username]
	pass = params[:password]
	@find = User.find_by_username(username)
	if @find == nil
		flash[:notice] = "New gossiper accepted. Please Log In"
		@user = User.create(username: params[:username], password: params[:password])
		redirect '/signin'
	else
		flash[:notice] = "Username already taken. Try again."
		redirect '/signup'
	end
end


#http://guides.rubyonrails.org/active_record_querying.html#dynamic-finders
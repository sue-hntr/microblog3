require 'sinatra'


not_found do
	status 404
	'not found'
end


get '/form' do
  erb :form
end

post '/form' do
  "You said '#{params[:message]}'"
end


#3 singing with sinatra
#passing RANDOM parameters into GET or POST method or route
# get '/more/*' do
# 	params[:splat]
# end


#2 singing with sinatra
#anything after hello will 
#be contained in a params array with the key: name
#the params array contains all the GET and POST variable
# get '/hello/:name/:city' do
# 	"Hello there, #{params[:name]} from #{params[:city]}."
# end


#1 singing with sinatra
# get '/about' do
# 	' a little about me'
	
# end
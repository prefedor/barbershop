
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'


get '/' do
	erb "Hello!!! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
erb :about
end

get '/visit' do
erb :visit
end

get '/contacts' do
erb :contacts
end

post '/visit' do 
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]

	@title = 'Thank You!'
	@message ="Dear #{@username}, we'll be waiting for you at #{@date}"
    
    f = File.open 'users.txt', 'a'
    f.write "User: #{@username}, Phone: #{@phone} date_time% #{@date} \n" 
    f.close 

	erb :message
end


post '/contacts' do 
	@user_mail = params[:user_email]
	@user_message = params[:user_message]
	

	@title = 'Thank You!'
	@message ="Your message is sent, the answer will be sent at  #{@user_mail}"
    
    f = File.open 'users_message.txt', 'a'
    f.write "User: #{@user_mail}, \n message: #{@user_message} \n" 
    f.close 

	erb :message
end



require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db

end

configure do #инициализация базы данных скьюлайт
	db=get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
	"Users" 
	("ID" INTEGER PRIMARY KEY AUTOINCREMENT, 
	 "username" TEXT, 
	 "phone" TEXT, 
	 "datestamp" TEXT, 
	 "barber" TEXT,
	 "color" TEXT
	  )'
end


   

get '/' do
	erb "Hello!!! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	@error= 'smth wrong'
erb :about
end

get '/visit' do
erb :visit
end

get '/contacts' do
erb :contacts
end

# #get '/showusers' do
#   erb :showusers
# end

post '/visit' do 
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]
	@barber = params[:barber]
	@color = params[:color]


    hh = {:username => 'Введите имя', 
    	  :phone => 'Введите номер телефона',
    	  :date => 'Неправильная дата-время'}
#для каждрй пары ключ значение
    hh.each do |key, value|
			if params[key] == ''
	#переменной еррор присвоить значение из хэша хх
				@error = hh[key]
#вернуть представление в взит
				return erb :visit
  		 	end
  	end
    ##@error = hh.select {|key,_ | params[key] == ""}.values.join(",")
  	## if @error != ''
  	##return erb :visit

	#if @username == ''
		#@error = 'Введите имя'
	#end

	#if @phone == ''
		#@error = 'Введите номер телефона'
	#end

	#if @date == ''
		#@error = 'Неправильная дата-время'
	#end

	#if @error == ''
		#return erb :visit
	#end

# записываем в базу данных введенные в форме на странице визит значения
 	db=get_db
	db.execute 'insert into 
	    Users
		(
			username, phone, datestamp, barber, color
		)
		values (?, ?, ?, ?, ?)', [@username, @phone, @date, @barber, @color]
 

	@title = 'Thank You!'
	@message ="Dear #{@username}, we'll be waiting for you at #{@date}"
    
    f = File.open 'users.txt', 'a'
    f.write "User: #{@username},\n Phone: #{@phone} date_time% #{@date} \n Barber #{@barber} \n Color #{@color} " 
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

get '/showusers' do 
     db =get_db
	
	@results = db.execute 'select * from Users order by id desc' 
	# print row['username']
	# print "\t-\t"
	# puts row['datestamp']
	# puts '==============' 
	erb :showusers
end
configure :development do

 ActiveRecord::Base.establish_connection(
   :adapter  => 'postgresql',
   :host     => 'localhost',
   :username => 'postgres',
   :password => 'postgres',
   :database => 'sinatra_development',
   :encoding => 'SQL_ASCII'
 )
end

require 'sinatra'
require 'sinatra/activerecord'


set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true
require './models'

get "/" do


erb :index
end

post "/" do

User.create(params[:comment])

end

get "/profile" do

erb :profile
end



get "/blog/:id" do

erb :otherprofile
end

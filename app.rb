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

redirect "/login"
end

get "/login" do

erb :login
end

post "/login" do
  user_name_given = params[:username]
  password_given = params[:password]

  user = User.where(username: user_name_given).first

  if user.password == password_given
    session[:user_id] = user.id

    redirect "/profile"
  else
    redirect "/login"
  end


end

get "/logout" do
  session[:user_id] = nil
  redirect '/login'

end

get "/profile" do
  @blogs = User.find(session[:user_id]).blogs

erb :profile
end

post "/profile" do
content = params[:content]

Blog.create(user_id: session[:user_id], content: content)

redirect "/profile"
end

get "/blogpost/:id" do
@user = User.find(session[:user_id]).username
@blog_id = params[:id]
@blog = Blog.find(@blog_id)

@comments = @blog.comments
erb :blogpost
end

post "/blogpost" do
blog_id = params[:blog_id]
p blog_id
Comment.create(user_id: session[:user_id], blog_id: blog_id, acomment: params[:acomment])


redirect "/blogpost/#{blog_id}"
end
get "/blog/:id" do

erb :otherprofile
end

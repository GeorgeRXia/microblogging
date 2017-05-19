require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'


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

  if !user
  	flash[:notice] = "Wrong Username and/or Password!"
    redirect "/login"
  elsif user.password != password_given
    redirect "/login"
  else
    session[:user_id] = user.id
    redirect "/profile"
  end


end

get "/logout" do
  session[:user_id] = nil
  redirect '/login'

end

get "/profile" do
  @blogs = User.find(session[:user_id]).blogs
  @other_users = User.all
  erb :profile
end

post "/profile" do
  content = params[:content]
  Blog.create(user_id: session[:user_id], content: content)
  redirect "/profile"
end

get "/edit" do
  User.find(session[:user_id])[:email]


@user = User.find(session[:user_id])



erb :edit

end

post "/edit" do

  if params[:delete]

User.find(session[:user_id]).delete
    redirect "/"
  end

    params[:comment]. each do |key,value|
      if value == ""
        params[:comment].delete(key)
      end
    end
 params[:comment]

User.update(session[:user_id],params[:comment] )
  redirect "/profile"
end

get "/blogpost/:id" do
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


get "/otherprofile/:id" do

@other_user = User.find(params[:id])
end


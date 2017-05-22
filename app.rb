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
  User.create(params[:user])
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

  if session[:user_id] == nil
    flash[:logged] = "You Must First Log In To Access Profile"

    redirect '/login'
  end

  @user = User.find(session[:user_id])
  @blogs = @user.blogs
  @user = User.find(session[:user_id])
  @blogs = @user.blogs
  @other_users = User.all
  @friendrequests = Request.where(otheruser_id: session[:user_id])
  @friends = Friend.where(user_id: session[:user_id])
  @friendsother = Friend.where(friend_id: session[:user_id])


  erb :profile

end

post "/profile" do
  content = params[:content]
  Blog.create(user_id: session[:user_id], content: content)
  redirect "/profile"

end

get "/edit" do
  @user = User.find(session[:user_id])
  erb :edit

end

post "/edit" do
  if params[:delete]
    User.find(session[:user_id]).destroy
    session[:user_id] = nil

    redirect "/"
  end

  params[:user]. each do |key,value|
    if value == ""
      params[:user].delete(key)
    end

  end

  User.update(session[:user_id],params[:user] )
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
  Comment.create(user_id: session[:user_id], blog_id: blog_id, acomment: params[:acomment])

  redirect "/blogpost/#{blog_id}"
end

get "/otherprofile/:id" do
  @other_user = User.find(params[:id])
  @CurrentUserFriendscheck = User.find(session[:user_id]).friends
  @CurrentUserFriendscheck2 = Friend.where(friend_id: session[:user_id])
  erb :otherprofile
end

post "/favoriteblogs/:id" do
  blogUsersId = params[:otheruser]
  blogcontent = Blog.find(params[:id]).content


historyOfPastFavoriteBlogs = Favoriteblog.all

historyOfPastFavoriteBlogs.each do |pastblog|

  if pastblog.blog_id == params[:id].to_i
  redirect "/otherprofile/" << blogUsersId
end
end

  Favoriteblog.create(user_id: session[:user_id], blogcontent: blogcontent, blog_id: params[:id])

  redirect "/otherprofile/" << blogUsersId
end


get "/favoriteblogs" do
@favoriteblogs = Favoriteblog.all

  erb :favoriteblogs

end

post "/friendrequest" do
other_user = params[:otheruser].to_i

Request.create(user_id: session[:user_id], otheruser_id: other_user)

redirect back
end


post "/createfriend/:id" do

Friend.create(user_id: session[:user_id], friend_id: params[:id])

Request.find(params[:requestid].to_i).destroy

redirect back
end


post "/reblog/:id" do

  redirect "/profile"
end

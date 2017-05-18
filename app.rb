require 'sinatra'
require 'sinatra/activerecord'


set :database, "sqlite3:firstdb.sqlite3"
set :sessions, true
require './models'

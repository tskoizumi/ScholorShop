require 'bundler/setup'
require 'logger'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

get '/' do
    erb :index
end

get '/new_item' do
    erb :new_item
end

get '/login' do
    erb :login
end

get '/register' do
    erb :register
end

get '/item/:id' do
    @item_id = params[:id]
    erb:item
end

post '/register' do
    user = User.create(name: params[:name], email: params[:email], point: 99999, password: params[:password])

    session[:user_id] = user.id
    redirect '/'
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end
end

post '/new_item' do
    redirect '/login' unless current_user
    image = params[:image]
    filename = Time.now.strftime('%Y%m%d%H%M%S') + "_" + image[:filename]
    File.open("./public/uploads/#{filename}", 'wb') do |f|
        f.write(image[:tempfile].read)
    end
    Item.create(
        name: params[:name],
        explanation: params[:explanation],
        price: params[:price],
        locker_pass: params[:locker_pass],
        image: "/uploads/#{filename}",
        user_id: current_user.id
    )
    redirect '/'
end

get '/logout' do
    session.clear
    redirect '/'
end

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end
end



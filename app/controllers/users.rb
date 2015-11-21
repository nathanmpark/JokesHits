enable :sessions

get '/users' do
  erb :'user/index'
end

get '/users/new' do
  erb :'user/new'
end

post '/users' do
  @user = User.new(params)
  if @user && @user.save
    session[:id] = @user.id
    redirect "/user/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    redirect '/users/new'
  end
end


get '/users/:id' do
  erb :'user/users'
end

get '/users/:id/edit' do
  erb :'user/edit'
end

put '/users/:id' do
  erb :'user/users'
end

delete '/users/:id' do
  redirect '/'
end

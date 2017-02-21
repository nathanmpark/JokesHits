enable :sessions

# get '/users' do
#   erb :'user/index'
# end

get '/usersss' do
  erb :'users/new'
end

# post '/users' do
#   @user = User.new(params)
#   if @user && @user.save
#     session[:id] = @user.id
#     redirect "/user/#{@user.id}"
#   else
#     @errors = @user.errors.full_messages
#     redirect '/users/new'
#   end
# end

get '/users/new' do
  redirect 'https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=%2Fprofile&redirect_uri=https://jokeshits.herokuapp.com/users&response_type=code&client_id=1092575859346-dfnpd043pvl650ie3a7l1fmotlo1c2ha.apps.googleusercontent.com'
end


get '/users/:id' do
  erb :'users/show'
end

# get '/users/:id/edit' do
#   erb :'users/edit'
# end

# put '/users/:id' do
#   erb :'users/users'
# end

# delete '/users/:id' do
#   redirect '/'
# end


get '/users' do
  body = {
    code: params[:code],
    client_id: '1092575859346-dfnpd043pvl650ie3a7l1fmotlo1c2ha.apps.googleusercontent.com',
    client_secret: ENV['CLIENT_SECRET'],
    redirect_uri: 'https://jokeshits.herokuapp.com/users',
    grant_type: 'authorization_code'
  }
  p post_response = HTTParty.post("https://accounts.google.com/o/oauth2/token", body: body)
  p get_response =  HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{post_response['access_token']}")

  email = get_response["emails"][0]["value"]
  name = get_response["displayName"]

  p @user = User.new(first_name: name, email: email)
  if @user && @user.save
    session[:id] = @user.id
    redirect '/'
  else
    flash[:errors] = "Login failed! Please try again"
    redirect '/'
  end
end


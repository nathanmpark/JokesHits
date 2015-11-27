get '/sessions/new' do
  redirect 'https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=%2Fprofile&redirect_uri=http://localhost:9393/sessions&response_type=code&client_id=1020476674313-siqcb9ncfralo2qtgf37f2m96la4erpm.apps.googleusercontent.com'
end

get '/sessions' do
  body = {
    code: params[:code],
    client_id: ENV['CLIENT_ID'],
    client_secret: ENV['CLIENT_SECRET'],
    redirect_uri: 'http://localhost:9393/sessions',
    grant_type: 'authorization_code'
  }
  post_response = HTTParty.post("https://accounts.google.com/o/oauth2/token", body: body)
  get_response =  HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{post_response['access_token']}")

  email = get_response["emails"][0]["value"]
  name = get_response["displayName"]

  @user = User.find_by_email(email)
  if @user
    session[:id] = @user.id
    redirect '/'
  else
    flash[:errors] = "Login failed! Please try again"
    redirect '/'
  end
end

get '/sessions/delete' do
 session[:id] = nil
 redirect '/'
end

####### Just for testing ######
get '/session' do
  session.inspect
end

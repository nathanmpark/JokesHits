# get '/contacts/new' do
#   redirect 'https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=%2Fprofile&redirect_uri=http://localhost:9393/contacts&response_type=code&client_id=1020476674313-siqcb9ncfralo2qtgf37f2m96la4erpm.apps.googleusercontent.com'
# end

# # client = OAuth2::Client.new(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], :site => 'https://example.org')

# # client.auth_code.authorize_url(:redirect_uri => 'http://localhost:9393/contacts')
# # # => "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"

# # token = client.auth_code.get_token('authorization_code_value', :redirect_uri => 'http://localhost:9393/contacts', :headers => {'Authorization' => 'Basic some_password'})

# get '/contacts' do
#   p params[:code]
#   site_path = 'http://localhost:9393'

#   redirect_uri = 'http://localhost:9393/contacts'
#  p ENV['CLIENT_ID']
#   client = OAuth2::Client.new(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], :site => site_path)
#   p "THIS IS THE AUTHORIZE URL"
#   p client.auth_code.authorize_url(:redirect_uri => redirect_uri)
#   p "8" * 80
#   p "THIS IS THE TOKEN BELOW"
#   # p token = client.client_credentials.get_token
#   p token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
#   p "*" * 90
#   p "THIS IS THE RESPONSE BELOW"
#   p response = token.get('/api/v1/people', :headers => { 'Accept' => 'application/json' }, :params => { page: 1 })

# end

get '/contacts' do
  @contacts = current_user.contacts
  erb :'contacts/index'
end

get '/contacts/new' do
  erb :'contacts/new'
end

post '/contacts' do
  @contact = Contact.new(first_name: params[:first_name], last_name: params[:last_name], number: params[:number], user_id: current_user.id)
  if @contact && @contact.save
    redirect "/contacts"
  else
    @errors = @contact.errors.full_messages
    redirect '/contacts/new'
  end
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :'contacts/show'
end

get '/contacts/:id/edit' do

end

put '/contacts/:id' do

end

delete '/contacts/:id' do
  redirect '/'
end

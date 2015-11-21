get '/contacts' do
  erb :'contacts/index'
end

get '/contacts/new' do
  erb :'contacts/new'
end

post '/contacts' do
  @contact = Contact.new(first_name: params[:first_name], last_name: params[:last_name], number: params[:number], user_id: current_user.id)
  if @contact && @contact.save
    redirect "/contacts/#{@contact.id}"
  else
    @errors = @contact.errors.full_messages
    redirect '/contacts/new'
  end
end


get '/contacts/:id' do
  @contact = Contact.find(params[:id])
  erb :'contacts/show'
end

# get '/contacts/:id/edit' do

# end

# put '/contacts/:id' do

# end

# delete '/contacts/:id' do
#   redirect '/'
# end

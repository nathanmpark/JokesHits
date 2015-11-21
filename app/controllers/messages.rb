get '/messages' do
  # all you previous messages with contacts
  erb :'messages/index'
end

get '/messages/new' do
  @contacts = current_user.contacts
  p @contacts
  erb :'messages/new'
end

post '/messages' do

end

get '/messages/:id' do

end

get '/messages/:id/edit' do

end

put '/messages/:id' do

end

delete '/messages/:id' do
  redirect '/'
end

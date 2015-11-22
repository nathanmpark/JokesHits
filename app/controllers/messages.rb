# require 'twilio-ruby'

get '/messages' do
  # all you previous messages with contacts
  erb :'messages/index'
end

get '/messages/new' do
  @contacts = current_user.contacts
  @source = Resource.all

  erb :'messages/new'
end

post '/messages' do
  @contact = Contact.find(params[:id])
  @source = Resource.find(params[:api_id])

  account_sid = 'AC3124f6b1ef51ec688e5d3ec3338ab0a6'
  auth_token = '855bddcd83ba05865561d4c8e2f6cfc0'

  @client = Twilio::REST::Client.new account_sid, auth_token
  resp = Net::HTTP.get_response(URI.parse(@source.link))

  # Is needed because @text evaluates ruby commands stored in the database!!!
  data = resp.body     # <----
  joke = JSON.parse(data) # <----

  @text = eval(@source.access)
  @client.account.messages.create({
    :from => '+16505499548',
    :to => @contact.number,
    :body => @text,
  })
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

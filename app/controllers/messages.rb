# require 'twilio-ruby'

get '/messages' do
  p "*" * 90
  p params[:contact_id]
  p "*" * 90
  @message = Message.where(contact_id: params[:contact_id]).select("message")
  return erb :'_message', locals: {messages: @message}, layout: false
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

  account_sid = ENV['TWILLIO_SID']
  auth_token = ENV['TWILLIO_AUTH_TOKEN']

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

 test =  Message.new(contact_id: @contact.id, user_id: current_user.id, message: @text)
 test.save
 redirect '/messages/new'
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

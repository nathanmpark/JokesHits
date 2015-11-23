require 'faker'

10.times do
  User.create(username: Faker::Internet.user_name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password")
end

100.times do
  Contact.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, number: Faker::Number.number(10), user_id: rand(1..10))
end

1000.times do
  Message.create(user_id: rand(1..10), contact_id: rand(1..100), message: Faker::Lorem.sentence)
end

Resource.create(name: "Yo Mamma", link: "http://api.yomomma.info/", access: "joke['joke']")
Resource.create(name: "Chuck Norris", link: "http://api.icndb.com/jokes/random?exclude=Array", access: "joke['value']['joke']")

User.create(first_name: "Paul", last_name: "Etscheit", email: "12345", password: "ger11840")
Contact.create(first_name: "Chris", last_name: "Mark", number: "5104272088", user_id: 11)

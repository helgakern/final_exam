# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Bid.delete_all
Auction.delete_all
User.delete_all

super_user = User.create(
  first_name: "John",
  last_name: "Doe",
  email: "johndoe@gmail.com",
  password: "supersecret",
  is_admin: true
)

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@gmail.com",
    password: "supersecret"
  )
end

users = User.all

5.times do
  created_at = Faker::Date.backward(days: 10)
  end_at = Faker::Date.forward(days: 30)

  auction = Auction.create(

    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    reserve_price: rand(100_0),
    aasm_state: :published,
    end_date: end_at,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if auction.valid?
    auction.bids = rand(0..10).times.map do
      Bid.new(
        amount: rand(0..300),
        user: users.sample
      )
    end

  end
end

auction = Auction.all


puts Cowsay.say("Generated #{Auction.count} auctions", :dragon)
puts Cowsay.say("Generated #{Bid.count} bids", :cow)
puts Cowsay.say("Created #{users.count} users", :tux)
puts "Login with #{super_user.email} and password of '123'"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
    User.create(fname: Faker::Name.first_name, lname: Faker::Name.last_name, email: Faker::Internet.unique.email, password: 'password', is_nurse: true)
    User.create(fname: Faker::Name.first_name, lname: Faker::Name.last_name, email: Faker::Internet.unique.email, password: 'password', is_nurse: false)
end

30.times do
    Pet.create(name: Faker::Creature::Cat.name, user_id: rand(0..21))
end

30.times do
    Service.create(name: Faker::Book.title, description: Faker::Quote.famous_last_words, price: rand(14..71), user_id: rand(5..15))
end
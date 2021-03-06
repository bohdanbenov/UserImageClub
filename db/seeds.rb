# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

100.times do |user|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  e_mail = Faker::Internet.safe_email(first_name+last_name)
  u_age = Faker::Number.between(1, 120)
  u_sex = Faker::Gender.binary_type
  u_bio = Faker::Lorem.paragraph_by_chars(295, false)
  password = Faker::Internet.password
  User.create!(
          first_name: first_name,
          last_name: last_name,
          email: e_mail,
          age: u_age,
          sex: u_sex,
          about: u_bio,
          password: password,
          password_confirmation: password,
          is_admin: false,
          address: Address.new(zip: Faker::Number.between(10000, 99999),
                               city: Faker::Address.city,
                               street: Faker::Address.street_address,
                               home_number: Faker::Number.between(1, 4999))
  )
  puts "User was created #{user}"
end
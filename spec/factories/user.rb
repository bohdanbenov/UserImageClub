# This will guess the User class
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    email { "email@example.com" }
    password {'123456'}
    age {15}
    about {"ttr"}
    sex {'Male'}
    address
  end
end
User.create(first_name: "Week", last_name: "Weeker", email:"weekerapp@gmail.com", password: "password")

20.times do
  User.create(first_name: Faker::Name.name.split(" ").first, last_name: Faker::Name.name.split(" ").last, email: Faker::Internet.email, password: "password")
end

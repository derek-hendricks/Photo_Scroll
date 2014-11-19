Author.create!(full_name: "example name",
               username:  "example123username",
               profile: Faker::Lorem.sentence(3, true),
               admin: true,
               email: "person678@gmail.com",
               password:              "foobar",
               password_confirmation: "foobar",
               activated: true,
               activated_at: Time.zone.now)
               

99.times do |n|
  full_name  = Faker::Name.name
  username = "name-#{n+1}"
  profile = Faker::Lorem.sentence(3, true)
  admin = false
  email = "example-#{n+1}@gmail.com"
  password = "password"
  Author.create!(full_name:  full_name,
               username: username,
               profile: profile, 
               admin: admin,
               email: email,
               password:              password,
               password_confirmation: password,
              activated: true,
             activated_at: Time.zone.now)
end
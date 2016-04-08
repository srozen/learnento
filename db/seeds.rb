# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
                {email: 'alice@gmail.com', password: 'password', first_name: 'Alice', last_name: 'Liddell'},
                {email: 'bob@gmail.com', password: 'password', first_name: 'Robert', last_name: 'Langdon'},
                {email: 'charlie@gmail.com', password: 'password', first_name: 'Charlie', last_name: 'Bucket'}
            ])

200.times do |i|
  User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.user_name + i.to_s +
          "@#{Faker::Internet.domain_name}",
      password: Faker::Internet.password(10, 20))
end
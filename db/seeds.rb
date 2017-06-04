# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  user = User.new(  name:                   Faker::Name.first_name,
                    surname:                Faker::Name.last_name,
                    password:               123456,
                    password_confirmation:  123456
                  )
  user.email = "#{user.name}.#{user.surname}@gmail.com"
  user.save!
  [1,2,3,4,5].sample.times do
    user.posts.create(content: Faker::Lorem.sentence(5, false, 6))
  end
end

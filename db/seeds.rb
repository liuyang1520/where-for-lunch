# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "admin",
						email: "liuyang1520@gmail.com",
						password: "test123456",
						password_confirmation: "test123456",
						admin: true)

100.times do |i|
	User.create(name: "test" + (i+1).to_s,
							email: "test#{i+1}@test.com",
							password: "test123456",
							password_confirmation: "test123456")
end
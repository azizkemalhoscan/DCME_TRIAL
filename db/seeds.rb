# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

puts "Cleaning Database"

User.destroy_all
Project.destroy_all
Survey.destroy_all

puts "Creating Users.."

User.create(email: "nick@dcme.today", password: "123456", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
User.create(email: "aziz@dcme.today", password: "123456", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
User.create(email: "susanna@dcme.today", password: "123456", first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)


puts "Creating Projects"

User.all.each do |user|
	2.times do
		Project.create! ({
			name: Faker::Job.field,
			user: user
		})
	end
end

puts "Creating Surveys"

Project.all.each do |project|
	1.times do
		Survey.create! ({
			name: Faker::Job.key_skill,
			project: project
		})
	end
end

puts "Finished Creating Database"

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

3.times do 
	@user = User.create! ({
		email:Faker::Internet.email,
		password: "123456"
	})
end

puts "Creating Projects"

User.all.each do |user|
	3.times do 
		Project.create! ({
			name: Faker::Job.field,
			user: user
		})
	end
end

puts "Creating Surveys"

Project.all.each do |project|
	3.times do 
		Survey.create! ({
			name: Faker::Job.key_skill,
			project: project
		})
	end
end

puts "Finished Creating Database"

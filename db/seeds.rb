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
SurveyQuestion.destroy_all
QuestionAnswer.destroy_all
Participant.destroy_all

puts "Creating Users.."

User.create(first_name: "Nick", last_name: "De Mil", username: "nickdemil", email: "nick@dcme.today", password: "123456")
User.create(first_name: "Susanna", last_name: "Jacob", username: "sjacob", email: "susanna@dcme.today", password: "123456")
User.create(first_name: "Aziz", last_name: "Hoscan", username: "azizhoscan",email: "aziz@dcme.today", password: "123456")

puts "Creating Projects"

User.all.each do |user|
	2.times do
		Project.create! ({
			name: Faker::Books::Lovecraft.deity,
			user: user
		})
	end
end

puts "Creating Surveys"
@token = ENV['TYPEFORM_API_TOKEN']

Project.all.each do |project|
	1.times do
		@survey = Survey.create! ({
			name: Faker::Books::Lovecraft.location,
			project: project
		})
	end

	if @survey.save
      begin
        response =
          RestClient.post(
            "https://api.typeform.com/forms", {
              title: @survey.name
            }.to_json, Authorization: "bearer #{@token}")
        rescue Exception =>
          raise
      end
      @response = JSON.parse(response)
      @survey.typeform_id = @response["id"]
      @survey.save
    end
end


puts "Creating Questions"

Survey.all.each do |survey|
	5.times do
		SurveyQuestion.create! ({
			question: Faker::Quotes::Shakespeare.as_you_like_it_quote,
			survey_id: survey.id,
			q_type: ["short_text", "opinion_scale"].sample,
		})
	end
end

puts "Creating Participants"

SurveyQuestion.all.each do |question|
	Participant.create! ({
		email: Faker::Internet.email,
		survey_id: question.survey.id,
	})
end

puts "Creating Answers"

Participant.all.each do |participant|
	SurveyQuestion.all.each do |question|
		QuestionAnswer.create! ({
			participant_id: participant.id,
			survey_question_id: question.id,
			response: rand(1..10)
		})
	end
end

puts "Finished Creating Database"

require 'json'
require 'rest-client'

class QuestionAnswersController < ApplicationController
  # before_action :set_question_answer, only: [:show, :create]
  before_action :responses
  # before_action :calculate_average, only: [:show, :index]

  def new
    @question_answer = QuestionAnswer.new
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def set_question_answer
    @question_answer = QuestionAnswer.find(params[:id])
    # authorize @question_answer
  end

  def question_answer_params
    params.require(:question_answer).permit(:survey_question_id)
  end

  def responses
    @token = ENV['TYPEFORM_API_TOKEN']
    @survey = Survey.find(params[:survey_id])
    @survey_questions = @survey.survey_questions
    @url = 'https://api.typeform.com/'
    @url += "forms/#{@survey.typeform_id}/responses"
    response = RestClient.get(@url, Authorization: "bearer #{@token}")
    @response = JSON.parse(response)
    if @response["items"].any?
      if @response["items"][0]["answers"]
        @response["items"].each_with_index do |item, i|
          unless item["answers"].nil? || item["answers"].empty?
            item["answers"].each do |answer|
              if answer["field"]["type"] == "email"
                unless Participant.find_by(email: answer["email"], survey_id: @survey.id)
                  @participant = Participant.create(email: answer["email"], survey_id: @survey.id)
                else
                  @participant = Participant.find_by(email: answer["email"], survey_id: @survey.id)
                end
              end
              @survey_questions.each do |squestion| 
                if squestion.typeform_id == answer["field"]["id"]
                  qanswer = QuestionAnswer.new(survey_question_id: squestion.id)
                  if answer["email"]
                    qanswer.response = answer["email"]
                  end
                  if answer["text"]
                    qanswer.response = answer["text"]
                  end
                  if answer["number"]
                    qanswer.response = answer["number"]
                  end
                  qanswer.participant = @participant
                  if QuestionAnswer.exists?(participant_id: @participant, survey_question_id: squestion.id)
                    next 
                  else
                    qanswer.save
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

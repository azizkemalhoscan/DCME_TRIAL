require 'json'
require 'rest-client'

class QuestionAnswersController < ApplicationController
  # before_action :set_question_answer, only: [:show, :create]
  before_action :responses

  def new
    @question_answer = QuestionAnswer.new
  end

  def create
    @question_answer.save
    # Need some redirecting
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
    @url = 'https://api.typeform.com/'
    @url += "forms/#{@survey.typeform_id}/responses"
    response = RestClient.get(@url, Authorization: "bearer #{@token}")
    @response = JSON.parse(response)
    @response["items"].each do |item|
      item["answers"].each do |answer|
        if answer["type"] == "text"
          unless Participant.where(email: answer["text"]).length > 0
            Participant.create!(email: answer["text"], survey_id: @survey.id)
          end
        end
      end
    end
  end
end

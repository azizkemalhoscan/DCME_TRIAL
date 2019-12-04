require 'json'
require 'rest-client'

class QuestionAnswersController < ApplicationController
  # before_action :set_question_answer, only: [:show, :create]
  before_action :responses

  def new
    @question_answer = QuestionAnswer.new
  end

  def create
    # Totally wrong!
    @survey_question = SurveyQuestion.find(params[:id])
    @question_answer = QuestionAnswer.new(question_answer_params)
    @question_answer.survey_question = @survey_question
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
  end
end

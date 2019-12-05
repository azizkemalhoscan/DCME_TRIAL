require 'json'
require 'rest-client'

class SurveysController < ApplicationController
  before_action :set_survey, only: [:create, :show]

  def index
    # @surveys = policy_scope(Survey)
    # authorize @surveys
    @surveys = Survey.all

    @survey = Survey.new

    @survey_question = SurveyQuestion.new
  end

  def new
    @project = Project.find(params[:project_id])
    @survey = Survey.new
  end

  def create
    @token = ENV["TYPEFORM_API_TOKEN"]
    @survey = Survey.create(survey_params)
    # authorize @survey
    @project = Project.find(params[:project_id])
    @survey.project = @project
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

      redirect_to project_path(@project)
    end

  end

  def show
    @token = ENV["TYPEFORM_API_TOKEN"]
    @survey = Survey.find(params[:id])
    @survey_question = SurveyQuestion.new

    #Typeform Gem
    # if @survey.typeform_id.nil?
    #   @form = CreateFormRequest.new(Form.new(title: @survey.name), token: @token).form
    #   @survey.typeform_id = @form.id
    #    @survey.save
    # end
  end

  def edit
  end

  def update
    @token = ENV["TYPEFORM_API_TOKEN"]
    @survey = Survey.find(params[:id])
    @survey.completed = true
    @survey.save

    add_to_typeform(@survey)

    @url = 'https://api.typeform.com/'
    @url += "forms/#{@survey.typeform_id}"
    response_test = RestClient.get(@url, Authorization: "bearer #{@token}")
    @response_final = JSON.parse(response_test)

    @survey.survey_questions.each_with_index do |question, i|
      question.typeform_id = @response_final["fields"][i]["id"]
      question.save
    end

    redirect_to survey_path(@survey)
  end

  def destroy
    @survey = Survey.find(params[:id])
    @project_id = @survey.project_id
    if @survey.destroy
      redirect_to project_path(@project_id)
    end
  end

  def feature
    @projects = Project.where(user: current_user)
    @projects.each do |project|
      project.surveys.each do |survey|
        survey.featured = false
        survey.save
      end
    end

    @survey = Survey.find(params[:survey]["featured_survey"])
    @survey.featured = true
    @survey.save
    redirect_to user_path(current_user)
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :project_id)
  end

  def set_survey
    # @survey = Survey.find(params[:id])
  end

    def add_to_typeform(survey)
    @all_questions = []

    survey.survey_questions.each do |question|
      question_hash = {
        "title": question.question,
        "type": question.q_type,
        "validations": {
          "required": true
        }
      }
      @all_questions << question_hash
    end
    begin
      RestClient.put(
          "https://api.typeform.com/forms/#{survey.typeform_id}", {
            title: survey.name,
            fields: @all_questions,
            welcome_screens: [
                {
                  "title": survey.name,
                  "properties": {
                    "description": @survey.welcome_messages[0].description,
                    "show_button": true,
                    "button_text": "start"
                  }
                }
            ]

          }.to_json, Authorization: "bearer #{@token}"
        )
    rescue Exception =>
        raise
    end
  end
end

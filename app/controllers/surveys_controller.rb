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

      redirect_to survey_path(@survey)
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
    @survey = Survey.find(params[:id])
    @survey.completed = true
    @survey.save
    redirect_to project_path(@survey.project)
  end

  def destroy
    @survey = Survey.find(params[:id])
    @project_id = @survey.project_id
    if @survey.destroy
      redirect_to project_path(@project_id)
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :project_id)
  end

  def set_survey
    # @survey = Survey.find(params[:id])
  end
end

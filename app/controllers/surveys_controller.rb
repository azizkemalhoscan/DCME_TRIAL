class SurveysController < ApplicationController
  #before_action :set_survey, only: [:create, :show]

  def index
    @surveys = policy_scope(Survey)
    # authorize @surveys

    @survey = Survey.new

    @survey_question = SurveyQuestion.new
  end

  def new
    @project = Project.find(params[:project_id])
    @survey = Survey.new

  end

  def create
    @survey = Survey.create(survey_params)
    # authorize @survey
    @project = Project.find(params[:project_id])
    @survey.project = @project
    if @survey.save
      redirect_to survey_path(@survey)
    end
  end

  def show
    @token = ENV["TYPEFORM_API_TOKEN"]
    @survey = Survey.find(params[:id])
    @survey_question = SurveyQuestion.new

    if @survey.typeform_id.nil?
      @form = CreateFormRequest.new(Form.new(title: @survey.name), token: @token).form
      @survey.typeform_id = @form.id
      @survey.save
    end

    # raise

    # if @survey.survey_questions.any?
    #   @question = @survey.survey_questions.last.question
    # else
    #   @question = 'Did not work'
    # end
    # # authorize @survey
    # @form.blocks << OpinionScaleBlock.new(title: @question)
    # @form = UpdateFormRequest.new(@form, token: @token).form

  end

  private

  def survey_params
    params.require(:survey).permit(:name, :project_id)
  end

  def set_survey
    @survey = Survey.find(params[:id])
  end
end

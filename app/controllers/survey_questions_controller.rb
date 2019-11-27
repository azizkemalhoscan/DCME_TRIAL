class SurveyQuestionsController < ApplicationController
  before_action :set_survey_question, only: [:show, :create]
  def new
    @survey_question = SurveyQuestion.new
  end

  def create
      @survey = Survey.find(params[:survey_id])
      @survey_question = SurveyQuestion.create(survey_question_params)
      @survey_question.survey = @survey
      @survey_question.save

      @token = ENV["TYPEFORM_API_TOKEN"]

      @form = RetrieveFormRequest.new(Form.new(id: @survey.typeform_id), token: @token).form

      @form.blocks << OpinionScaleBlock.new(title: @survey_question.question)

      @form = UpdateFormRequest.new(@form, token: @token).form

      @survey_question.typeform_id = @form.blocks.last.id
      @survey_question.save

      redirect_to survey_path(@survey)
  end

  def edit

    @survey = Survey.find(params[:id])

    @survey_question = SurveyQuestion.find(params[:format])

    render 'surveys/show'
  end

  def update

    @token = ENV["TYPEFORM_API_TOKEN"]

    @survey_question = SurveyQuestion.find(params[:id])

    if @survey_question.update(survey_question_params)

      @form = RetrieveFormRequest.new(Form.new(id: @survey_question.survey.typeform_id), token: @token).form

      @question_index = @form.blocks.index do |thing|
        thing.id == @survey_question.typeform_id
      end

      @form.blocks[@question_index].title = @survey_question.question

      @form = UpdateFormRequest.execute(@form, token: @token).form

      redirect_to survey_path(@survey_question.survey)

    else
      render(:edit)
    end
  end

  def destroy

    @token = ENV["TYPEFORM_API_TOKEN"]

    @survey_question = SurveyQuestion.find(params[:format])

      @form = RetrieveFormRequest.new(Form.new(id: @survey_question.survey.typeform_id), token: @token).form

      @question_index = @form.blocks.index do |thing|
        thing.id == @survey_question.typeform_id
      end

      @form.blocks.delete_at(@question_index)

      @form = UpdateFormRequest.new(@form, token: @token).form

      if @survey_question.delete

        redirect_to survey_path(@survey_question.survey)

      else
        render(:edit)
      end
  end


	def index
    @survey_questions = SurveyQuestion.all
	end

	def show
	end

  private

  def set_survey_question
    # @survey_question = SurveyQuestion.find(params[:id])
    # authorize @survey_question
  end

  def survey_question_params
    params.require(:survey_question).permit(:question)
  end
end

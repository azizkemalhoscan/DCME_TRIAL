class SurveyQuestionsController < ApplicationController
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

    redirect_to survey_path(@survey)
	end

  def edit

    @survey = Survey.find(params[:id])

    @survey_question = SurveyQuestion.find(params[:format])

    render 'surveys/show'
  end

  def update
    @survey_question = SurveyQuestion.find(params[:id])

    if @survey_question.update(survey_question_params)
      redirect_to survey_path(@survey_question.survey)
    else
      render(:edit)
    end
  end


	def index
	end

	def show
	end

  private


  def survey_question_params
    params.require(:survey_question).permit(:question)
  end
end

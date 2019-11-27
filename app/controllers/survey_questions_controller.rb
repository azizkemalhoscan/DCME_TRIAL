class SurveyQuestionsController < ApplicationController
  before_action :set_survey_question, only: [:show, :create]
	def new
		@survey_question = SurveyQuestion.new
	end

	def create
    @survey_question.save
	end

	def index
    @survey_questions = SurveyQuestion.all
	end

	def show
	end

  private

  def set_survey_question
    @survey_question = SurveyQuestion.find(params[:id])
    # authorize @survey_question
  end

  def survey_question_params
    params.require(:survey_question).permit(:question)
  end
end

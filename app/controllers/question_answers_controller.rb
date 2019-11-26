class QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: [:show, :create]
	def new
    @question_answer = QuestionAnswer.new
	end

	def create
    @question_answer.save
    # Need some redirecting
	end

	def index
    @question_answers = QuestionAnswer.all
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
end

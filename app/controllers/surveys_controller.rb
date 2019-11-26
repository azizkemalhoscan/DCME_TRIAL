class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
  end

  def index
    @surveys = Survey.all

    @survey_question = SurveyQuestion.new
    @question_answer = QuestionAnswer.new
  end

  def show
  end

  private 

  def survey_params
    params.require(:survey).permit(:name, :project_id)
  end
end

class SurveyQuestionsController < ApplicationController
  before_action :set_survey_question, only: [:show]
  before_action :responses, only: [:show]
  before_action :set_token, only: [:destroy, :create, :update]

	def new
		@survey_question = SurveyQuestion.new
	end

  def index
    @survey_questions = SurveyQuestion.all
  end

  def show
    @question_answers = []
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @survey_question = SurveyQuestion.new(survey_question_params)
    @survey_question.survey = @survey
    @survey_question.save

    append_new_question

    @survey_question.typeform_id = @form.blocks.last.id
    @survey_question.save

    respond_to do |format|
      format.html { redirect_to survey_path(@survey) }
      format.js
    end

  end

  def edit
    @survey_question = SurveyQuestion.find(params[:id])

    respond_to do |format|
      format.html { redirect_to survey_path(@survey) }
      format.js
    end

    # render 'surveys/show'
  end

  def update
    @survey_question = SurveyQuestion.find(params[:id])

    if @survey_question.update(survey_question_params)
      update_form_question

      respond_to do |format|
        format.html { redirect_to survey_path(@survey) }
        format.js
      end
    else
      render(:edit)
    end
  end

  def destroy
    @survey_question = SurveyQuestion.find(params[:format])
    delete_form_question

    if @survey_question.delete

      redirect_to survey_path(@survey_question.survey)
    else
      render(:edit)
    end
  end

  private

  def set_survey_question
    @survey_question = SurveyQuestion.find(params[:id])
    # authorize @survey_question
  end

  def set_token
    @token = ENV["TYPEFORM_API_TOKEN"]
  end

  def survey_question_params
    params.require(:survey_question).permit(:question, :q_type)
  end

  def responses
    @token = ENV['TYPEFORM_API_TOKEN']
    @survey = @survey_question.survey
    @url = 'https://api.typeform.com/'
    @url += "forms/#{@survey.typeform_id}/responses"
    response = RestClient.get(@url, Authorization: "bearer #{@token}")
    @response = JSON.parse(response)
    if @response["items"][0]["answers"]
      @response["items"].each_with_index do |item, i|
        unless Participant.find_by_email(item["answers"][0]["text"])
          Participant.create(email: item["answers"][0]["text"], survey_id: @survey.id)
        else
          next
        end
      end
    end
  end



  def append_new_question
    @form = RetrieveFormRequest.new(Form.new(id: @survey.typeform_id), token: @token).form
    if @survey_question.q_type == "Rating Scale"
      @form.blocks << OpinionScaleBlock.new(title: @survey_question.question)
    elsif @survey_question.q_type == "Short Text"
      @form.blocks << ShortTextBlock.new(title: @survey_question.question)
    end
    @form = UpdateFormRequest.new(@form, token: @token).form
  end

  def update_form_question
    @form = RetrieveFormRequest.new(Form.new(id: @survey_question.survey.typeform_id), token: @token).form
    @q_index = @form.blocks.index { |t| t.id == @survey_question.typeform_id }
    @form.blocks[@q_index].title = @survey_question.question
    @form = UpdateFormRequest.execute(@form, token: @token).form
  end

  def delete_form_question
    @form = RetrieveFormRequest.new(Form.new(id: @survey_question.survey.typeform_id), token: @token).form
    @q_index = @form.blocks.index { |t| t.id == @survey_question.typeform_id }
    @form.blocks.delete_at(@q_index)
    @form = UpdateFormRequest.new(@form, token: @token).form
  end
end

class WelcomeMessagesController < ApplicationController
  before_action :set_welcome_message, only: [:show]
  # before_action :welcome_responses, only: [:show]
  before_action :set_token, only: [:destroy, :create, :update]

  def new
    @welcome_message = WelcomeMessage.new
    @survey = Survey.find(params[:survey_id])
  end

  def index
    @welcome_messages = WelcomeMessage.all
  end

  def show
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @welcome_message = WelcomeMessage.create(welcome_message_params)
    @welcome_message.survey = @survey
    @welcome_message.save

    # append new survey
    # why last id down there
    # begin
    #   RestClient.put(
    #     "https://api.typeform.com/forms/#{@survey.typeform_id}", {
    #       title: @welcome_message.survey.name,
    #       welcome_screens: [
    #         {
    #           title: @welcome_message.description
    #         }
    #       ]
    #     }.to_json, Authorization: "bearer #{ENV['TYPEFORM_API_TOKEN']}")
    # rescue
    # end
    redirect_to survey_path(@survey)
  end

  def edit
    @survey = Survey.find(params[:id])
    @welcome_message = WelcomeMessage.find(params[:welcome_format])
    render 'surveys/show'
  end

  def update
    @welcome_message = WelcomeMessage.find(params[:id])

    if @welcome_message.update(welcome_message_params)
      # HERE A NEW METHOD UNDER PRIVATE SECTION
      redirect_to survey_path(@welcome_message.survey)
    else
      render(:edit)
    end
  end

  def destroy
    @welcome_message = WelcomeMessage.find(params[:welcome_format])

    if @welcome_message.delete
      redirect_to survey_path(@welcome_message.survey)
    else
      render(:edit)
    end
  end

  private

  def set_welcome_message
    @welcome_message = WelcomeMessage.find(params[:id])
  end
  # If API token changes change variable's name

  def set_token
    @token = ENV["TYPEFORM_API_TOKEN"]
  end

  def welcome_message_params
    params.require(:welcome_message).permit(:description)
  end

  # def welcome_responses
  #   @token = ENV['TYPEFORM_API_TOKEN']
  #   @survey = @welcome_message.survey
  #   @url = 'https://api.typeform.com/forms'
  #   # @url += "forms/#{@survey.typeform_id}/responses"
  #   welcome_response = RestClient.post(@url, Authorization: "bearer #{@token}")
  #   @welcome_response = JSON.parse(welcome_response)
  # end
end

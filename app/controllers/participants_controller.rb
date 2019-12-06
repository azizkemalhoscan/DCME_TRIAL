class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:create, :show]

	def create
    @participant.save
    redirect_to participant_path(@participant)
	end

	def index
    # @participants = Participant.all
    @participants = Survey.find(params[:survey_id]).participants
    @survey = Survey.find(params[:survey_id])
	end

	def show
    @participants = @participant.survey.participants
	end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:email)
  end
end

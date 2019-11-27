class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:create, :show]

	def create
    @participant.save
    redirect_to participant_path(@participant)
	end

	def index
    @participants = Participant.all
	end

	def show
	end

  private

  def participant_params
    params.require(:participant).permit(:first_name, :last_name)
end

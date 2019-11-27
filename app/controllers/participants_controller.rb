class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:create, :show]
	def new
    @participant = Participant.new
	end

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

  def set_participant
    @participant = Participant.find(params[:id])
    # authorize @participant
  end

  def participant_params
    params.require(:participant).permit(:first_name, :last_name)
end

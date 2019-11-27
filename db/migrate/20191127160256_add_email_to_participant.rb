class AddEmailToParticipant < ActiveRecord::Migration[5.2]
  def change
  	remove_column :participants, :first_name
  	remove_column :participants, :last_name
  	add_column :participants, :email, :string
  end
end

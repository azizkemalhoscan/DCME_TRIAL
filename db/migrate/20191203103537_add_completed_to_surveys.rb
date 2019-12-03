class AddCompletedToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :completed, :boolean, default: false
  end
end

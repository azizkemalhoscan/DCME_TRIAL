class AddTypformIdToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :typeform_id, :string
  end
end

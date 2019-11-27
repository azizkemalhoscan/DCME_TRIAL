class AddTypeformToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :typeform, :boolean
  end
end

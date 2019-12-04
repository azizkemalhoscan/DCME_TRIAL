class AddFeaturedToSurveys < ActiveRecord::Migration[5.2]
  def change
    add_column :surveys, :featured, :boolean, default: false
  end
end

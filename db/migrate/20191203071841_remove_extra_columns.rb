class RemoveExtraColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :surveys, :typeform
  end
end

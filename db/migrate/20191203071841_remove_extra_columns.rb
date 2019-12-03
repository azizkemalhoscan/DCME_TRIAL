class RemoveExtraColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :surveys, :typeform
    remove_column :survey_questions, :typeform_id
  end
end

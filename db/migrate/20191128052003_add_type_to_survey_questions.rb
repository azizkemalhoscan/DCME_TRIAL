class AddTypeToSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :survey_questions, :q_type, :string
  end
end

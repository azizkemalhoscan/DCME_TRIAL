class CreateQuestionAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :question_answers do |t|
      t.references :survey_question, foreign_key: true
      t.references :participant, foreign_key: true
      t.integer :response_int

      t.timestamps
    end
  end
end

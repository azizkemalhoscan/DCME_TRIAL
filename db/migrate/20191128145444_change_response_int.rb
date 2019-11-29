class ChangeResponseInt < ActiveRecord::Migration[5.2]
  def change
  	remove_column :question_answers, :response_int
  	add_column :question_answers, :response, :text
  end
end

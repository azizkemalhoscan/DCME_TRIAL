class CreateThankyouScreens < ActiveRecord::Migration[5.2]
  def change
    create_table :thankyou_screens do |t|
      t.string :title
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end

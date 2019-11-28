class AddSurveyReferenceToWelcomeMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :welcome_messages, :survey
  end
end

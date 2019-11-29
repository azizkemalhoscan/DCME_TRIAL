class QuestionAnswer < ApplicationRecord
  belongs_to :survey_question
  belongs_to :participant, dependent: :destroy

  serialize :response_int
end

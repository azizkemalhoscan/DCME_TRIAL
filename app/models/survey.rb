class Survey < ApplicationRecord
  belongs_to :project

  has_many :participants
  has_many :survey_questions
end

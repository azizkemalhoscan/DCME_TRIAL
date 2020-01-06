class Survey < ApplicationRecord
  belongs_to :project
  has_many :welcome_messages, dependent: :destroy

  has_many :participants, dependent: :destroy
  has_many :survey_questions, dependent: :destroy
end

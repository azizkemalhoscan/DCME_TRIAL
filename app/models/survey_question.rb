class SurveyQuestion < ApplicationRecord
  belongs_to :survey

  has_many :question_answers, dependent: :destroy

  validates :q_type, presence: true
end

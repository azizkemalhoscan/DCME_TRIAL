class WelcomeMessage < ApplicationRecord
  belongs_to :survey

  has_many :question_answers
end

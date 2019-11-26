class Project < ApplicationRecord
  belongs_to :user

  has_many :surveys
  has_many :participants, through: :surveys
end

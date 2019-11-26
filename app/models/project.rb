class Project < ApplicationRecord
  belongs_to :user

  has_many :surveys, dependent: :destroy
  has_many :participants, through: :surveys, dependent: :destroy
end

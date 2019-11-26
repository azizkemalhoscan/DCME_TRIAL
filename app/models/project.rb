class Project < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_many :surveys
end

class Diagnosis < ApplicationRecord
  belongs_to :user

  belongs_to :cancer

  validates :stage, inclusion: 1..4
end

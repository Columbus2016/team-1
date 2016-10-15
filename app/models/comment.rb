class Comment < ApplicationRecord
  belongs_to :shout
  belongs_to :user

  validates :user, presence: true

  validates :shout, presence: true
end

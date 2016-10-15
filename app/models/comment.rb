class Comment < ApplicationRecord
  belongs_to :shout
  belongs_to :user
end

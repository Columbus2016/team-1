class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :diagnosis

  has_one :cancer,
    through: :diagnosis

  has_many :shouts

  has_many :comments

  accepts_nested_attributes_for :diagnosis

  enum gender: [:male, :female, :other]
  enum authority: [:user, :researcher, :moderator, :admin]
end

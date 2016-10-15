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

  scope :visible, ->{ where(invisible: false) }
  scope :invisible, -> { where(invisible: true) }

  attr_accessor :location_lat
  attr_accessor :location_long


  before_save :convert_location


  protected


  def convert_location
    return unless location_lat && location_long
    puts "Location_lat #{location_lat} and long #[location_long}"
    self.location = RGeo::ActiveRecord::SpatialFactoryStore.instance.default.point(location_long, location_lat)
  end
end

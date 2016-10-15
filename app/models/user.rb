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

  def self.by_filter(params, other)
    filter = self
    if params[:my_cancer]
      filter = filter.with_cancer(other.cancer)
    end

    if params[:age_start]
      filter = filter.at_least_age(params[:age_start])
    end

    if params[:age_end]
      filter = filter.at_least_age(params[:age_end])
    end
    
    if params[:within_distance]
      filter = filter.within_distance(other.location)
    end
  end

  def self.with_cancer(cancer)
    filter = filter.joins(diagnosis: :cancer)
        .references(diagnosis: :cancer)
        .where(diagnoses: {cancer: other.cancer})

  end

  def self.at_least_age(years)
    where("date_part('year', age(birthdate)) > ?",
          years)
  end

  def self.at_most_age(years)
    where("date_part('year', age(birthdate)) < ?",
          years)
  end

  def self.within_distance(point, dist)
    where("ST_DWithin(location, ?, ?)",point,dist * 1609.34)
  end

  protected

  def convert_location
    return unless location_lat && location_long
    puts "Location_lat #{location_lat} and long #[location_long}"
    self.location = RGeo::ActiveRecord::SpatialFactoryStore.instance.default.point(location_long, location_lat)
  end
end

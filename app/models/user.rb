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
    filter = self.all

    unless params[:my_cancer].blank?
      filter = filter.with_cancer(other.cancer)
    end

    unless params[:age_start].blank?
      puts "using my cancer"
      filter = filter.at_least_age(params[:age_start])
    end

    unless params[:age_end].blank?
      filter = filter.at_least_age(params[:age_end])
    end
    
    unless params[:within_miles].blank?
      filter = filter.within_miles(other.location, params[:within_miles].to_f)
    end

    return filter
  end

  def self.with_cancer(cancer)
    joins(diagnosis: :cancer)
        .references(diagnosis: :cancer)
      .where(diagnoses: {cancer_id: cancer})
  end

  def self.at_least_age(years)
    where("date_part('year', age(birthdate)) > ?",
          years)
  end

  def self.at_most_age(years)
    where("date_part('year', age(birthdate)) < ?",
          years)
  end

  def self.within_miles(point, dist)
    puts "point #{point} dist #{dist.inspect}"
    where("ST_DWithin(location, ?, ?)",point,dist * 1609.34)
  end

  def self.with_friendship_status_for(other)
    joins("LEFT OUTER JOIN friendships ON friendships.receiver_id = users.id")
      .group("users.id, friendships.id")
      .select("users.*, friendships.id AS friendship_id")
  end

  protected

  def convert_location
    return unless location_lat && location_long
    puts "Location_lat #{location_lat} and long #[location_long}"
    self.location = RGeo::ActiveRecord::SpatialFactoryStore.instance.default.point(location_long, location_lat)
  end
end

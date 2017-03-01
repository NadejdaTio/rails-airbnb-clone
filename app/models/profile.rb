class Profile < ApplicationRecord
  belongs_to :user
  has_many :games, dependent: :destroy
  has_many :orders, dependent: :destroy
  # has_many :order_reviews, dependent: :destroy
  has_many :player_reviews, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_attachment :photo
end

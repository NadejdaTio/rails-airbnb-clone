class Order < ApplicationRecord
  belongs_to :game
  belongs_to :profile
  has_many :owner_reviews, dependent: :destroy
  has_many :player_reviews, dependent: :destroy
  #before_save TODO
end

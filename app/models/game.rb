class Game < ApplicationRecord
  belongs_to :profile
  has_many :availabilities, dependent: :destroy
  has_many :orders, dependent: :destroy
end

class OwnerReview < ApplicationRecord
  belongs_to :profile
  belongs_to :order
end

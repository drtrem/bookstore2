class Comment < ApplicationRecord
  belongs_to :product
  validates :rate, presence: true
end

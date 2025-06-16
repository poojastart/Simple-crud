class Product < ApplicationRecord
  paginates_per 10
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :image
end
class Product < ApplicationRecord
  paginates_per 10
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :image
  after_create_commit -> { broadcast_append_to "products", partial: "products/product", locals: { product: self }, target: "products" }
  after_update_commit -> { broadcast_replace_to "products", partial: "products/product", locals: { product: self }, target: "product_#{self.id}" }
  after_destroy_commit -> { broadcast_remove_to "products", target: "product_#{self.id}" }
  scope :ordered, -> { order(id: :asc) }
end
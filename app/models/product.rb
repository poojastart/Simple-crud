class Product < ApplicationRecord
  paginates_per 10
  belongs_to :user
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_one_attached :image
  belongs_to :category, optional: true

  after_create_commit -> { broadcast_append_to "products", partial: "products/product", locals: { product: self }, target: "products" }
  after_update_commit -> { broadcast_replace_to "products", partial: "products/product", locals: { product: self }, target: "product_#{self.id}" }
  after_destroy_commit -> { broadcast_remove_to "products", target: "product_#{self.id}" }
  scope :on_sale, -> { where('compare_at_price > price AND compare_at_price IS NOT NULL') }
  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :ordered, -> { order(id: :asc) }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "compare_at_price", "description", "id", "is_active", "name", "price"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def on_sale?
    compare_at_price.present? && compare_at_price > price
  end
end
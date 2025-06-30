class AddColumnToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :is_active, :boolean, default: true, null: false
    add_column :products, :compare_at_price, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
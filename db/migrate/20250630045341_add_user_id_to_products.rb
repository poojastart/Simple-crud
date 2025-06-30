class AddUserIdToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :user_id, :bigint, null: false, default: 9
    add_foreign_key :products, :users
  end
end

class RemoveSlugFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_index :categories, :slug if index_exists?(:categories, :slug)
    remove_column :categories, :slug, :string
  end
end

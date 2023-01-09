class AddImageToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :image, :string
  end
end

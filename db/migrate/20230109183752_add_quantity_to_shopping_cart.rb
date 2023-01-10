class AddQuantityToShoppingCart < ActiveRecord::Migration[7.0]
  def change
    add_column :shopping_carts, :quantity, :integer
  end
end

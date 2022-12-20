class AddDeliveredToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :delivered, :boolean
  end
end

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.float :price
      t.string :image
      t.integer :quantity
      t.integer :stock
      t.integer :rating
      t.text :description
      t.string :dosage
      t.string :effects

      t.timestamps
    end
  end
end

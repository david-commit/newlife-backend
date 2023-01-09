class AddDosageToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :dosage, :string
  end
end

class CreateDosageConsiderations < ActiveRecord::Migration[7.0]
  def change
    create_table :dosage_considerations do |t|
      t.string :consideration
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

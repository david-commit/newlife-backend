class CreateSideEffects < ActiveRecord::Migration[7.0]
  def change
    create_table :side_effects do |t|
      t.string :side_effect
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

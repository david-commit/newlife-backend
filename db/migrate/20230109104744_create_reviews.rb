class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :description_header
      t.string :description_content
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end

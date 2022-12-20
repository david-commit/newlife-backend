class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.belongs_to :payment, foreign_key: true
      t.string :merchant_request_id
      t.string :response_description
      t.integer :response_code
      t.string :customer_message

      t.timestamps
    end
  end
end

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      # t.belongs_to :order, foreign_key: true
      t.integer :business_short_code
      t.string :password
      t.datetime :timestamp
      t.string :transaction_type
      t.integer :party_A, limit: 8
      t.integer :party_B, limit: 8
      t.integer :phone_number
      t.string :callback_url
      t.string :account_reference
      t.string :transaction_desc
      t.integer :amount

      t.timestamps
    end
  end
end

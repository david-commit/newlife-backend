class CreatePractitioners < ActiveRecord::Migration[7.0]
  def change
    create_table :practitioners do |t|
      t.string :username
      t.string :password_digest
      t.string :email

      t.timestamps
    end
  end
end

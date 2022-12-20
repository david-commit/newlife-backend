class CreatePractitionerProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :practitioner_profiles do |t|
      t.belongs_to :practitioner, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.date :dob
      t.string :phone_number
      t.string :location
      t.string :blood_group
      t.float :weight
      t.float :bmi

      t.timestamps
    end
  end
end

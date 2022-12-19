class CreatePatientProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_profiles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.date :dob
      t.string :location
      t.string :blood_group
      t.float :height
      t.float :weight
      t.string :phone_number
      t.float :bmi

      t.timestamps
    end
  end
end
